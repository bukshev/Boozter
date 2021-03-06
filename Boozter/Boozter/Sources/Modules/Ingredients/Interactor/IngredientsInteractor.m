//
//  IngredientsInteractor.m
//  Boozter
//
//  Created by Букшев Иван Евгеньевич on 19.02.2021.
//  Copyright © 2021 Team Absurdum. All rights reserved.
//

#import "IngredientsInteractor.h"
#import "IIngredientsInteractorOutput.h"
#import "IIngredientsService.h"
#import "Ingredient.h"

@interface IngredientsInteractor ()
@property (nonatomic, strong) id<IIngredientsService> ingredientsService;
@end

@implementation IngredientsInteractor

#pragma mark - Initialization

- (instancetype)initWithIngredientsService:(id<IIngredientsService>)ingredientsService {
    assert(nil != ingredientsService);

    self = [super init];

    if (nil != self) {
        _ingredientsService = ingredientsService;
    }

    return self;
}

- (void)injectOutput:(id<IIngredientsInteractorOutput>)output {
    _output = output;
}

#pragma mark - IIngredientsInteractorInput

- (void)obtainAvailableIngredients {
    [self.ingredientsService obtainAvailableIngredients:[self obtainIngredientsCompletion]];
}

- (void)obtailDetailsForIngredient:(Ingredient *)ingredient {
    [self.ingredientsService obtainDetailsForIngredient:ingredient
                                      completionHamdler:[self obtainIngredientDetailsCompletion]];
}

#pragma mark - Private helpers

- (ObtainIngredientsCompletion)obtainIngredientsCompletion {
    __weak typeof(self) weakSelf = self;

    ObtainIngredientsCompletion handler = ^(NSArray<Ingredient *> *ingredients, NSError *error) {
        typeof(self) strongSelf = weakSelf;
        if (nil == strongSelf) {
            return;
        }

        if (nil != error) {
            [strongSelf.output didFailObtainIngredientsWithError:error];
        } else if (nil != ingredients) {
            [strongSelf.output didObtainIngredients:ingredients];
        } else {
            NSAssert(false, @"Unexpected behaviour in %s. 'ingredients' and 'error' are nil.", __PRETTY_FUNCTION__);
        }
    };

    return [handler copy];
}

- (ObtainIngredientDetailsCompletion)obtainIngredientDetailsCompletion {
    __weak typeof(self) weakSelf = self;

    ObtainIngredientDetailsCompletion handler = ^(NSString *ingredientDetails, NSError *error) {
        typeof(self) strongSelf = weakSelf;
        if (nil == strongSelf) {
            return;
        }

        if (nil != error) {
            [strongSelf.output didFailObtainIngredientDetailsWithError:error];
        } else if (nil != ingredientDetails) {
            [strongSelf.output didObtainIngredientDetails:ingredientDetails];
        } else {
            NSAssert(false, @"Unexpected behaviour in %s. 'ingredientDetails' and 'error' are nil.", __PRETTY_FUNCTION__);
        }
    };

    return [handler copy];
}

@end

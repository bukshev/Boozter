//
//  IngredientsService.m
//  Boozter
//
//  Created by Букшев Иван Евгеньевич on 19.02.2021.
//  Copyright © 2021 Team Absurdum. All rights reserved.
//

#import "IngredientsService.h"

#import "ICoreCache.h"
#import "ICoreNetwork.h"

#import "GetIngredientsNetworkOperation.h"
#import "GetIngredientDetailsNetworkOperation.h"

#import "Ingredient.h"

@interface IngredientsService ()
@property (nonatomic, strong) id<ICoreCache> coreCache;
@property (nonatomic, strong) id<ICoreNetwork> coreNetwork;
@end

@implementation IngredientsService

#pragma mark - Initialization

- (instancetype)initWithCoreCache:(id<ICoreCache>)coreCache
                      coreNetwork:(id<ICoreNetwork>)coreNetwork {

    assert(nil != coreCache);
    assert(nil != coreNetwork);

    self = [super init];

    if (nil != self) {
        _coreCache = coreCache;
        _coreNetwork = coreNetwork;
    }

    return self;
}

#pragma mark - IIngredientsService

- (void)obtainAvailableIngredients:(ObtainIngredientsCompletion)completionHandler {
    assert(NULL != completionHandler);

    void (^completion)(NSArray<NSString *> *) = ^(NSArray<Ingredient *> *ingredients) {
        completionHandler(ingredients, nil);
    };

    GetIngredientsNetworkOperation *operation = [[GetIngredientsNetworkOperation alloc] initWithCompletion:completion];
    [self.coreNetwork executeOperation:operation];
}

- (void)obtainDetailsForIngredient:(Ingredient *)ingredient completionHamdler:(ObtainIngredientDetailsCompletion)completionHandler {
    assert(nil != ingredient);
    assert(NULL != completionHandler);

    void (^completion)(NSString *) = ^(NSString *ingredientDetails) {
        completionHandler(ingredientDetails, nil);
    };

    GetIngredientDetailsNetworkOperation *operation = [[GetIngredientDetailsNetworkOperation alloc] initWithIngredientName:ingredient.name
                                                                                                                completion:completion];

    [self.coreNetwork executeOperation:operation];
}

@end

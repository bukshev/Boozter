//
//  IngredientsModuleAssembly.m
//  Boozter
//
//  Created by Букшев Иван Евгеньевич on 19.02.2021.
//  Copyright © 2021 Team Absurdum. All rights reserved.
//

#import "IngredientsModuleAssembly.h"
#import <ViperMcFlurry/ViperMcFlurry.h>

#import "ServicesAssembly.h"
#import "UtilitiesAssembly.h"

#import "IngredientsViewController.h"
#import "IngredientsInteractor.h"
#import "IngredientsPresenter.h"

#import "IngredientsDataSource.h"

@interface IngredientsModuleAssembly ()
@property (nonatomic, strong, readonly) ServicesAssembly *servicesAssembly;
@property (nonatomic, strong, readonly) UtilitiesAssembly *utilitiesAssembly;
@end

@implementation IngredientsModuleAssembly

- (id<IModuleFactory>)factoryIngredientsModule {
    Class factoryClass = [RamblerViperModuleFactory class];
    return [TyphoonDefinition withClass:factoryClass configuration:^(TyphoonDefinition *definition) {
        SEL selector = @selector(initWithViewControllerLoader:andViewControllerIdentifier:);
        [definition useInitializer:selector parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:[self storyboardIngredientsModule]];
            [initializer injectParameterWith:@"IngredientsViewController"];
        }];
    }];
}

- (UIStoryboard *)storyboardIngredientsModule {
    Class storyboardClass = [TyphoonStoryboard class];
    return [TyphoonDefinition withClass:storyboardClass configuration:^(TyphoonDefinition *definition) {
        SEL selector = @selector(storyboardWithName:factory:bundle:);
        [definition useInitializer:selector parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:@"IngredientsViewController"];
            [initializer injectParameterWith:self];
            [initializer injectParameterWith:nil];
        }];
    }];
}

- (IngredientsViewController *)viewIngredientsModule {
    Class viewClass = [IngredientsViewController class];
    return [TyphoonDefinition withClass:viewClass configuration:^(TyphoonDefinition *definition) {
        [definition injectMethod:@selector(injectOutput:) parameters:^(TyphoonMethod *method) {
            [method injectParameterWith:[self presenterIngredientsModule]];
        }];
        [definition injectMethod:@selector(injectDataSource:) parameters:^(TyphoonMethod *method) {
            [method injectParameterWith:[self dataSourceIngredientsModule]];
        }];
    }];
}

- (IngredientsInteractor *)interactorIngredientsModule {
    Class interactorClass = [IngredientsInteractor class];
    return [TyphoonDefinition withClass:interactorClass configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(initWithIngredientsService:) parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:[self.servicesAssembly ingredientsService]];
        }];

        [definition injectMethod:@selector(injectOutput:) parameters:^(TyphoonMethod *method) {
            [method injectParameterWith:[self presenterIngredientsModule]];
        }];
    }];
}

- (IngredientsPresenter *)presenterIngredientsModule {
    Class presenterClass = [IngredientsPresenter class];
    return [TyphoonDefinition withClass:presenterClass configuration:^(TyphoonDefinition *definition) {
        SEL selector = @selector(initWithInteractor:imageDownloader:);
        [definition useInitializer:selector parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:[self interactorIngredientsModule]];
            [initializer injectParameterWith:[self.utilitiesAssembly imageDownloader]];
        }];
        [definition injectMethod:@selector(injectView:) parameters:^(TyphoonMethod *method) {
            [method injectParameterWith:[self viewIngredientsModule]];
        }];
        [definition injectMethod:@selector(injectDataSource:) parameters:^(TyphoonMethod *method) {
            [method injectParameterWith:[self dataSourceIngredientsModule]];
        }];
    }];
}

- (IngredientsDataSource *)dataSourceIngredientsModule {
    return [TyphoonDefinition withClass:[IngredientsDataSource class]];
}

@end

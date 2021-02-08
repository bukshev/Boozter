//
//  CoctailModuleAssembly.m
//  Boozter
//
//  Created by Ivan Bukshev on 03/09/2019.
//  Copyright © 2019 Team Absurdum. All rights reserved.
//

#import "CoctailModuleAssembly.h"
#import <ViperMcFlurry/ViperMcFlurry.h>

#import "UtilitiesAssembly.h"
#import "ServicesAssembly.h"

#import "CoctailViewController.h"
#import "CoctailPresenter.h"
#import "CoctailInteractor.h"

#import "ImageDownloader.h"

@interface CoctailModuleAssembly ()
@property (nonatomic, strong, readonly) UtilitiesAssembly *utilitiesAssembly;
@property (nonatomic, strong, readonly) ServicesAssembly *servicesAssembly;
@end

@implementation CoctailModuleAssembly

- (id<IModuleFactory>)factoryCoctailModule {
    Class factoryClass = [RamblerViperModuleFactory class];
    return [TyphoonDefinition withClass:factoryClass configuration:^(TyphoonDefinition *definition) {
        SEL selector = @selector(initWithViewControllerLoader:andViewControllerIdentifier:);
        [definition useInitializer:selector parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:[self storyboardCoctailModule]];
            [initializer injectParameterWith:@"CoctailViewController"];
        }];
    }];
}

- (UIStoryboard *)storyboardCoctailModule {
    Class storyboardClass = [TyphoonStoryboard class];
    return [TyphoonDefinition withClass:storyboardClass configuration:^(TyphoonDefinition *definition) {
        SEL selector = @selector(storyboardWithName:factory:bundle:);
        [definition useInitializer:selector parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:@"CoctailViewController"];
            [initializer injectParameterWith:self];
            [initializer injectParameterWith:nil];
        }];
    }];
}

- (CoctailViewController *)viewCoctailModule {
    Class viewClass = [CoctailViewController class];
    return [TyphoonDefinition withClass:viewClass configuration:^(TyphoonDefinition *definition) {
        [definition injectMethod:@selector(injectOutput:) parameters:^(TyphoonMethod *method) {
            [method injectParameterWith:[self presenterCoctailModule]];
        }];
    }];
}

- (CoctailPresenter *)presenterCoctailModule {
    Class presenterClass = [CoctailPresenter class];
    return [TyphoonDefinition withClass:presenterClass configuration:^(TyphoonDefinition *definition) {
        SEL selector = @selector(initWithInteractor:imageDownloader:);
        [definition useInitializer:selector parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:[self interactorCoctailModule]];
            [initializer injectParameterWith:[self.utilitiesAssembly imageDownloader]];
        }];
        [definition injectMethod:@selector(injectView:) parameters:^(TyphoonMethod *method) {
            [method injectParameterWith:[self viewCoctailModule]];
        }];
    }];
}

- (CoctailInteractor *)interactorCoctailModule {
    Class interactorClass = [CoctailInteractor class];
    return [TyphoonDefinition withClass:interactorClass configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(initWithCoctailsService:) parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:[self.servicesAssembly coctailsService]];
        }];
        [definition injectMethod:@selector(injectOutput:) parameters:^(TyphoonMethod *method) {
            [method injectParameterWith:[self presenterCoctailModule]];
        }];
    }];
}

@end

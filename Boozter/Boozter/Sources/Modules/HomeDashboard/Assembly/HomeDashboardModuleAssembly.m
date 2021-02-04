//
//  HomeDashboardModuleAssembly.m
//  Boozter
//
//  Created by Ivan Bukshev on 03/09/2019.
//  Copyright © 2019 Team Absurdum. All rights reserved.
//

#import "HomeDashboardModuleAssembly.h"

#import "CoctailModuleAssembly.h"
#import "ServicesAssembly.h"
#import "UtilitiesAssembly.h"

#import "HomeDashboardViewController.h"
#import "HomeDashboardInteractor.h"
#import "HomeDashboardPresenter.h"
#import "HomeDashboardRouter.h"

#import "HomeDashboardDataSource.h"

@interface HomeDashboardModuleAssembly ()
@property (nonatomic, strong, readonly) CoctailModuleAssembly *coctailModuleAssembly;
@property (nonatomic, strong, readonly) ServicesAssembly *servicesAssembly;
@property (nonatomic, strong, readonly) UtilitiesAssembly *utilitiesAssembly;
@end

@implementation HomeDashboardModuleAssembly

- (HomeDashboardViewController *)viewHomeDashboardModule {
    Class viewClass = [HomeDashboardViewController class];
    return [TyphoonDefinition withClass:viewClass configuration:^(TyphoonDefinition *definition) {
        [definition injectMethod:@selector(injectOutput:) parameters:^(TyphoonMethod *method) {
            [method injectParameterWith:[self presenterHomeDashboardModule]];
        }];
        [definition injectMethod:@selector(injectDataSource:) parameters:^(TyphoonMethod *method) {
            [method injectParameterWith:[self homeDashboardDataSource]];
        }];
    }];
}

- (HomeDashboardInteractor *)interactorHomeDashboardModule {
    Class interactorClass = [HomeDashboardInteractor class];
    return [TyphoonDefinition withClass:interactorClass configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(initWithCoctailsService:) parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:[self.servicesAssembly coctailsService]];
        }];

        [definition injectMethod:@selector(injectOutput:) parameters:^(TyphoonMethod *method) {
            [method injectParameterWith:[self presenterHomeDashboardModule]];
        }];
    }];
}

- (HomeDashboardPresenter *)presenterHomeDashboardModule {
    Class presenterClass = [HomeDashboardPresenter class];
    return [TyphoonDefinition withClass:presenterClass configuration:^(TyphoonDefinition *definition) {
        SEL selector = @selector(initWithInteractor:router:imageDownloader:);
        [definition useInitializer:selector parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:[self interactorHomeDashboardModule]];
            [initializer injectParameterWith:[self routerHomeDashboardModule]];
            [initializer injectParameterWith:[self.utilitiesAssembly imageDownloader]];
        }];
        [definition injectMethod:@selector(injectView:) parameters:^(TyphoonMethod *method) {
            [method injectParameterWith:[self viewHomeDashboardModule]];
        }];
        [definition injectMethod:@selector(injectDataSource:) parameters:^(TyphoonMethod *method) {
            [method injectParameterWith:[self homeDashboardDataSource]];
        }];
    }];
}

- (HomeDashboardRouter *)routerHomeDashboardModule {
    Class routerClass = [HomeDashboardRouter class];
    return [TyphoonDefinition withClass:routerClass configuration:^(TyphoonDefinition *definition) {
        SEL selector = @selector(initWithCoctailModuleFactory:);
        [definition useInitializer:selector parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:[self.coctailModuleAssembly factoryCoctailModule]];
        }];
        [definition injectMethod:@selector(injectTransitionHandler:) parameters:^(TyphoonMethod *method) {
            [method injectParameterWith:[self viewHomeDashboardModule]];
        }];
    }];
}

- (HomeDashboardDataSource *)homeDashboardDataSource {
    return [TyphoonDefinition withClass:[HomeDashboardDataSource class]];
}

@end

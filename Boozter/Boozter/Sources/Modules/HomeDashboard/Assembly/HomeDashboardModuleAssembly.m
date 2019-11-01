//
//  HomeDashboardModuleAssembly.m
//  Boozter
//
//  Created by Ivan Bukshev on 03/09/2019.
//  Copyright © 2019 Team Absurdum. All rights reserved.
//

#import "HomeDashboardModuleAssembly.h"

#import "CoctailModuleAssembly.h"

#import "HomeDashboardViewController.h"
#import "HomeDashboardInteractor.h"
#import "HomeDashboardPresenter.h"
#import "HomeDashboardRouter.h"

#import "CoreDataCache.h"
#import "CoreNetwork.h"
#import "CoctailsService.h"
#import "HomeDashboardDataSource.h"
#import "NetworkOperationQueue.h"
#import "ImageDownloader.h"
#import "ErrorProcessor.h"

@interface HomeDashboardModuleAssembly ()
@property (nonatomic, strong, readonly) CoctailModuleAssembly *coctailModuleAssembly;
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
            [initializer injectParameterWith:[self coctailsService]];
        }];

        [definition injectMethod:@selector(injectOutput:) parameters:^(TyphoonMethod *method) {
            [method injectParameterWith:[self presenterHomeDashboardModule]];
        }];
    }];
}

- (HomeDashboardPresenter *)presenterHomeDashboardModule {
    Class presenterClass = [HomeDashboardPresenter class];
    return [TyphoonDefinition withClass:presenterClass configuration:^(TyphoonDefinition *definition) {
        SEL selector = @selector(initWithInteractor:router:);
        [definition useInitializer:selector parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:[self interactorHomeDashboardModule]];
            [initializer injectParameterWith:[self routerHomeDashboardModule]];
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

- (id<ICoctailsService>)coctailsService {
    return [TyphoonDefinition withClass:[CoctailsService class] configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(initWithCoreCache:coreNetwork:imageDownloader:errorProcessor:) parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:[self coreCache]];
            [initializer injectParameterWith:[self coreNetwork]];
            [initializer injectParameterWith:[self imageDownloader]];
            [initializer injectParameterWith:[self errorProcessor]];
        }];
    }];
}

- (id<ICoreCache>)coreCache {
    return [TyphoonDefinition withClass:[CoreDataCache class] configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(initWithIdentifier:) parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:@"Boozter.xcdatamodeld"];
        }];
    }];
}

- (id<ICoreNetwork>)coreNetwork {
    return [TyphoonDefinition withClass:[CoreNetwork class] configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(initWithQueue:) parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:[self networkOperationQueue]];
        }];
    }];
}

- (id<IImageDownloader>)imageDownloader {
    return [ImageDownloader sharedInstance];
}

- (id<IErrorProcessor>)errorProcessor {
    return [TyphoonDefinition withClass:[ErrorProcessor class]];
}

- (NetworkOperationQueue *)networkOperationQueue {
    return [TyphoonDefinition withClass:[NetworkOperationQueue class]];
}

- (HomeDashboardDataSource *)homeDashboardDataSource {
    return [TyphoonDefinition withClass:[HomeDashboardDataSource class]];
}

@end

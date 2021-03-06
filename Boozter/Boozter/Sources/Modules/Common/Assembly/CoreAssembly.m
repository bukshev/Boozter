//
//  CoreAssembly.m
//  Boozter
//
//  Created by Букшев Иван Евгеньевич on 04.02.2021.
//  Copyright © 2021 Team Absurdum. All rights reserved.
//

#import "CoreAssembly.h"

#import "CoreDataCache.h"
#import "CoreNetwork.h"

#import "NetworkOperationQueue.h"

@implementation CoreAssembly

- (id<ICoreCache>)coreCache {
    return [TyphoonDefinition withClass:[CoreDataCache class] configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(initWithIdentifier:) parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:@"Boozter"];
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

- (NetworkOperationQueue *)networkOperationQueue {
    return [TyphoonDefinition withClass:[NetworkOperationQueue class]];
}

@end

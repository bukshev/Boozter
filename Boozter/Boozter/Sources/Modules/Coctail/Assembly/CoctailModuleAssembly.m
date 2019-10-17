//
//  CoctailModuleAssembly.m
//  Boozter
//
//  Created by Ivan Bukshev on 03/09/2019.
//  Copyright © 2019 Team Absurdum. All rights reserved.
//

#import "CoctailModuleAssembly.h"
#import <ViperMcFlurry/ViperMcFlurry.h>

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

@end

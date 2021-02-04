//
//  ServicesAssembly.m
//  Boozter
//
//  Created by Букшев Иван Евгеньевич on 04.02.2021.
//  Copyright © 2021 Team Absurdum. All rights reserved.
//

#import "ServicesAssembly.h"
#import "CoctailsService.h"
#import "CoreAssembly.h"

@interface ServicesAssembly ()
@property (nonatomic, strong, readonly) CoreAssembly *coreAssembly;
@end

@implementation ServicesAssembly

- (id<ICoctailsService>)coctailsService {
    return [TyphoonDefinition withClass:[CoctailsService class] configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(initWithCoreCache:coreNetwork:) parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:[self.coreAssembly coreCache]];
            [initializer injectParameterWith:[self.coreAssembly coreNetwork]];
        }];
    }];
}

@end

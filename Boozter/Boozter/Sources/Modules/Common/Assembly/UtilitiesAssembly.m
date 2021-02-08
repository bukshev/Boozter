//
//  UtilitiesAssembly.m
//  Boozter
//
//  Created by Букшев Иван Евгеньевич on 04.02.2021.
//  Copyright © 2021 Team Absurdum. All rights reserved.
//

#import "UtilitiesAssembly.h"
#import "ImageDownloader.h"

@implementation UtilitiesAssembly

- (id<IImageDownloader>)imageDownloader {
    return [TyphoonDefinition withClass:[ImageDownloader class] configuration:^(TyphoonDefinition *definition) {
        definition.scope = TyphoonScopeSingleton;
    }];
}

@end

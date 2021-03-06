//
//  CoreAssembly.h
//  Boozter
//
//  Created by Букшев Иван Евгеньевич on 04.02.2021.
//  Copyright © 2021 Team Absurdum. All rights reserved.
//

#import <Typhoon/Typhoon.h>

@protocol ICoreCache;
@protocol ICoreNetwork;

NS_ASSUME_NONNULL_BEGIN

@interface CoreAssembly : TyphoonAssembly

- (id<ICoreCache>)coreCache;
- (id<ICoreNetwork>)coreNetwork;

@end

NS_ASSUME_NONNULL_END

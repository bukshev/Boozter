//
//  CoctailModuleAssembly.h
//  Boozter
//
//  Created by Ivan Bukshev on 03/09/2019.
//  Copyright © 2019 Team Absurdum. All rights reserved.
//

#import <Typhoon/Typhoon.h>

@protocol IModuleFactory;

NS_ASSUME_NONNULL_BEGIN

@interface CoctailModuleAssembly : TyphoonAssembly

- (id<IModuleFactory>)factoryCoctailModule;

@end

NS_ASSUME_NONNULL_END

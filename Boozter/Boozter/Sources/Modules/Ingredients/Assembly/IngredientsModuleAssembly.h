//
//  IngredientsModuleAssembly.h
//  Boozter
//
//  Created by Букшев Иван Евгеньевич on 19.02.2021.
//  Copyright © 2021 Team Absurdum. All rights reserved.
//

#import <Typhoon/TyphoonAssembly.h>

@protocol IModuleFactory;

NS_ASSUME_NONNULL_BEGIN

@interface IngredientsModuleAssembly : TyphoonAssembly

- (id<IModuleFactory>)factoryIngredientsModule;

@end

NS_ASSUME_NONNULL_END

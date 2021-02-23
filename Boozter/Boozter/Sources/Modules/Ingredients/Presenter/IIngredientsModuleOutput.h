//
//  IIngredientsModuleOutput.h
//  Boozter
//
//  Created by Букшев Иван Евгеньевич on 19.02.2021.
//  Copyright © 2021 Team Absurdum. All rights reserved.
//

#import <ViperMcFlurry/ViperMcFlurry.h>

@class IngredientsFilter;

NS_ASSUME_NONNULL_BEGIN

@protocol IIngredientsModuleOutput <RamblerViperModuleOutput>

- (void)didSetFilter:(IngredientsFilter *)filter;

@end

NS_ASSUME_NONNULL_END

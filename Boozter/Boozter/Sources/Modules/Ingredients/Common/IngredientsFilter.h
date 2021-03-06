//
//  IngredientsFilter.h
//  Boozter
//
//  Created by Букшев Иван Евгеньевич on 19.02.2021.
//  Copyright © 2021 Team Absurdum. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Ingredient;

NS_ASSUME_NONNULL_BEGIN

@interface IngredientsFilter : NSObject

@property (nonatomic, copy, readonly) NSSet<Ingredient *> *ingredients;

- (instancetype)initWithIngredientsSet:(NSSet<Ingredient *> *)ingredients NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END

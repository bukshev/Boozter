//
//  IngredientItem.h
//  Boozter
//
//  Created by Букшев Иван Евгеньевич on 19.02.2021.
//  Copyright © 2021 Team Absurdum. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Ingredient;

NS_ASSUME_NONNULL_BEGIN

@interface IngredientItem : NSObject

@property (nonatomic, assign, readonly, getter=isSelected) BOOL selected;
@property (nonatomic, copy, readonly) NSString *ingredientName;

- (instancetype)initWithIngredient:(Ingredient *)ingredient
                          selected:(BOOL)selected NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;

- (void)setSelected:(BOOL)selected;

@end

NS_ASSUME_NONNULL_END

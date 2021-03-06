//
//  IngredientItem.m
//  Boozter
//
//  Created by Букшев Иван Евгеньевич on 19.02.2021.
//  Copyright © 2021 Team Absurdum. All rights reserved.
//

#import "IngredientItem.h"
#import "Ingredient.h"

@implementation IngredientItem

#pragma mark - Initialization

- (instancetype)initWithIngredient:(Ingredient *)ingredient selected:(BOOL)selected {
    assert(nil != ingredient);

    self = [super init];

    if (nil != self) {
        _selected = selected;
        _ingredientName = [ingredient.name copy];
    }

    return self;
}

- (void)setSelected:(BOOL)selected {
    _selected = selected;
}

@end

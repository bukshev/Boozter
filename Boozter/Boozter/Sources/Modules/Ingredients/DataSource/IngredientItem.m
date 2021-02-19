//
//  IngredientItem.m
//  Boozter
//
//  Created by Букшев Иван Евгеньевич on 19.02.2021.
//  Copyright © 2021 Team Absurdum. All rights reserved.
//

#import "IngredientItem.h"

@implementation IngredientItem

#pragma mark - Initialization

- (instancetype)initWithIngredient:(NSString *)ingredientName selected:(BOOL)selected {
    assert(nil != ingredientName);

    self = [super init];

    if (nil != self) {
        _selected = selected;
        _ingredientName = [ingredientName copy];
    }

    return self;
}

- (void)setSelected:(BOOL)selected {
    _selected = selected;
}

@end

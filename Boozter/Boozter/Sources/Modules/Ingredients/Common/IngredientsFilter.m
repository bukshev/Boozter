//
//  IngredientsFilter.m
//  Boozter
//
//  Created by Букшев Иван Евгеньевич on 19.02.2021.
//  Copyright © 2021 Team Absurdum. All rights reserved.
//

#import "IngredientsFilter.h"

@implementation IngredientsFilter

- (instancetype)initWithIngredientsSet:(NSSet<NSString *> *)ingredients {
    self = [super init];

    if (nil != self) {
        _ingredients = [ingredients copy];
    }

    return self;
}

@end

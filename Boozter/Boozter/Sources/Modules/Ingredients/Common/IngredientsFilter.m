//
//  IngredientsFilter.m
//  Boozter
//
//  Created by Букшев Иван Евгеньевич on 19.02.2021.
//  Copyright © 2021 Team Absurdum. All rights reserved.
//

#import "IngredientsFilter.h"

@interface IngredientsFilter ()
@property (nonatomic, copy) NSSet<NSString *> *allIngredients;
@property (nonatomic, copy) NSMutableSet<NSString *> *selectedIngredients;
@end

@implementation IngredientsFilter

- (instancetype)init {
    return [self initWithIngredientsSet:[NSSet set]];
}

- (instancetype)initWithIngredientsSet:(NSSet<NSString *> *)ingredients {
    self = [super init];

    if (nil != self) {
        _allIngredients = [ingredients copy];
        _selectedIngredients = [NSMutableSet set];
    }

    return self;
}

- (void)replaceAllIngredientsWithSet:(NSSet<NSString *> *)allIngredients {
    _allIngredients = [NSMutableSet setWithSet:allIngredients];
}

- (void)replaceSelectedIngredientsWithSet:(NSSet<NSString *> *)selectedIngredients {
    _selectedIngredients = [NSMutableSet setWithSet:selectedIngredients];
}

- (NSSet<NSString *> *)allIngredients {
    return [_allIngredients copy];
}

- (NSSet<NSString *> *)selectedIngredients {
    return [_selectedIngredients copy];
}

@end

//
//  IngredientsDataSource.m
//  Boozter
//
//  Created by Букшев Иван Евгеньевич on 19.02.2021.
//  Copyright © 2021 Team Absurdum. All rights reserved.
//

#import "IngredientsDataSource.h"
#import "IngredientItem.h"
#import "IngredientCell.h"
#import "Ingredient.h"

static NSUInteger const kNumberOfSections = 1;

@interface IngredientsDataSource ()
@property (nonatomic, copy) NSMutableArray<Ingredient *> *ingredients;
@property (nonatomic, copy) NSMutableArray<IngredientItem *> *items;
@end

@implementation IngredientsDataSource

#pragma mark - Initialization

- (void)injectTableView:(UITableView *)tableView {
    assert(nil != tableView);

    _tableView = tableView;
    _tableView.dataSource = self;

    UINib *nib = [UINib nibWithNibName:[IngredientCell reuseIdentifier] bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:[IngredientCell reuseIdentifier]];
}

#pragma mark - Public Interface

- (NSArray<Ingredient *> *)selectedIngredients {
    NSMutableArray<Ingredient *> *selectedIngredients = [NSMutableArray arrayWithCapacity:self.ingredients.count];

    [self.items enumerateObjectsUsingBlock:^(IngredientItem *obj, NSUInteger idx, BOOL * stop) {
        if (obj.isSelected) {
            [selectedIngredients addObject:self.ingredients[idx]];
        }
    }];

    return [selectedIngredients copy];
}

- (void)updateWithIngredients:(NSArray<Ingredient *> *)ingredients {
    assert(nil != ingredients);

    _ingredients = [ingredients mutableCopy];
    _items = [NSMutableArray arrayWithCapacity:ingredients.count];
    [ingredients enumerateObjectsUsingBlock:^(Ingredient *obj, NSUInteger idx, BOOL *stop) {
        IngredientItem *item = [[IngredientItem alloc] initWithIngredient:obj selected:NO];
        [self.items addObject:item];
    }];
}

- (nullable Ingredient *)ingredientForIndexPath:(NSIndexPath *)indexPath {
    assert(nil != indexPath);

    return (indexPath.row < self.ingredients.count) ? self.ingredients[indexPath.row] : nil;
}

- (void)updateSelectedStatus:(BOOL)selected forItemAt:(NSIndexPath *)indexPath {
    assert(nil != indexPath);

    if (indexPath.row >= self.items.count) {
        return;
    }

    IngredientItem *item = self.items[indexPath.row];
    [item setSelected:selected];
}

- (void)triggerSelectedStatusForIndexPath:(NSIndexPath *)indexPath {
    assert(nil != indexPath);

    if (indexPath.row >= self.ingredients.count) {
        return;
    }

    NSMutableArray *indexPathsForReload = [NSMutableArray arrayWithCapacity:self.ingredients.count];

    IngredientItem *item = self.items[indexPath.row];
    [item setSelected:!item.isSelected];

    [indexPathsForReload addObject:indexPath];

    [self.items enumerateObjectsUsingBlock:^(IngredientItem *obj, NSUInteger idx, BOOL *stop) {
        if (obj.isSelected && indexPath.row != idx) {
            [obj setSelected:NO];
            [indexPathsForReload addObject:[NSIndexPath indexPathForRow:idx inSection:0]];
        }
    }];

    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadRowsAtIndexPaths:indexPathsForReload withRowAnimation:UITableViewRowAnimationFade];
    });
}

- (void)tableView:(UITableView *)tableView
  willDisplayCell:(UITableViewCell *)dequeuedCell
forRowAtIndexPath:(NSIndexPath *)indexPath {

    BOOL const isIngredientCell = [dequeuedCell isKindOfClass:[IngredientCell class]];
    if (!isIngredientCell) {
        return;
    }

    IngredientCell *cell = (IngredientCell *)dequeuedCell;
    IngredientItem *item = self.items[indexPath.row];

    [cell configureWithItem:item];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return kNumberOfSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.ingredients.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *const reuseIdentifier = [IngredientCell reuseIdentifier];
    return [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
}

@end

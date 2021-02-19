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

static NSUInteger const kNumberOfSections = 1;

@interface IngredientsDataSource ()
@property (nonatomic, copy) NSMutableArray<NSString *> *ingredients;
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

- (void)updateWithIngredients:(NSArray<NSString *> *)ingredients {
    assert(nil != ingredients);

    _ingredients = [ingredients mutableCopy];
    _items = [NSMutableArray arrayWithCapacity:ingredients.count];
    [ingredients enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL *stop) {
        IngredientItem *item = [[IngredientItem alloc] initWithIngredient:obj];
        [self.items addObject:item];
    }];
}

- (NSString *)ingredientForIndexPath:(NSIndexPath *)indexPath {
    assert(nil != indexPath);

    return self.ingredients[indexPath.row];
}

- (void)tableView:(UITableView *)tableView
  willDisplayCell:(UITableViewCell *)dequeuedCell
forRowAtIndexPath:(NSIndexPath *)indexPath {

//    if (!tableView.isDragging) {
//        [self animateCell:dequeuedCell];
//    }

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

//
//  IngredientsDataSource.h
//  Boozter
//
//  Created by Букшев Иван Евгеньевич on 19.02.2021.
//  Copyright © 2021 Team Absurdum. All rights reserved.
//

#import <UIKit/UITableView.h>

@class Ingredient;

NS_ASSUME_NONNULL_BEGIN

@interface IngredientsDataSource : NSObject <UITableViewDataSource>

@property (nonatomic, weak, nullable, readonly) UITableView *tableView;

- (void)injectTableView:(UITableView *)tableView;

- (NSArray<Ingredient *> *)selectedIngredients;
- (void)updateWithIngredients:(NSArray<Ingredient *> *)ingredients;

- (nullable Ingredient *)ingredientForIndexPath:(NSIndexPath *)indexPath;
- (void)triggerSelectedStatusForIndexPath:(NSIndexPath *)indexPath;

- (void)tableView:(UITableView *)tableView
  willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END

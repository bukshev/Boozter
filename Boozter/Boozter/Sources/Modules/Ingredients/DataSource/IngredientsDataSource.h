//
//  IngredientsDataSource.h
//  Boozter
//
//  Created by Букшев Иван Евгеньевич on 19.02.2021.
//  Copyright © 2021 Team Absurdum. All rights reserved.
//

#import <UIKit/UITableView.h>

NS_ASSUME_NONNULL_BEGIN

@interface IngredientsDataSource : NSObject <UITableViewDataSource>

@property (nonatomic, weak, nullable, readonly) UITableView *tableView;

- (void)injectTableView:(UITableView *)tableView;

- (NSArray<NSString *> *)selectedIngredients;
- (void)updateWithIngredients:(NSArray<NSString *> *)ingredients;

- (nullable NSString *)ingredientForIndexPath:(NSIndexPath *)indexPath;
- (void)triggerSelectedStatusForIndexPath:(NSIndexPath *)indexPath;

- (void)tableView:(UITableView *)tableView
  willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END

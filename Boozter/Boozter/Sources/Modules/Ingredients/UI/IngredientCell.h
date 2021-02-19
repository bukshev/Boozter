//
//  IngredientCell.h
//  Boozter
//
//  Created by Букшев Иван Евгеньевич on 19.02.2021.
//  Copyright © 2021 Team Absurdum. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IngredientItem;

NS_ASSUME_NONNULL_BEGIN

@interface IngredientCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIStackView *stackView;
@property (nonatomic, weak) IBOutlet UIImageView *selectionImageView;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;

+ (NSString *)reuseIdentifier;

- (void)configureWithItem:(IngredientItem *)item;

@end

NS_ASSUME_NONNULL_END

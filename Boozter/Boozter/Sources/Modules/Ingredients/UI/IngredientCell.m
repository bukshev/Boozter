//
//  IngredientCell.m
//  Boozter
//
//  Created by Букшев Иван Евгеньевич on 19.02.2021.
//  Copyright © 2021 Team Absurdum. All rights reserved.
//

#import "IngredientCell.h"
#import "IngredientItem.h"

@implementation IngredientCell

#pragma mark - Lifecycle

- (void)awakeFromNib {
    assert(nil != self.nameLabel);

    [super awakeFromNib];

    [self setupInProgressState];
}

- (void)prepareForReuse {
    [super prepareForReuse];

    [self setupInProgressState];
}

#pragma mark - Public Interface

+ (NSString *)reuseIdentifier {
    return NSStringFromClass([self class]);
}

- (void)configureWithItem:(IngredientItem *)item {
    assert(nil != item);
    assert(NSThread.isMainThread);

    self.nameLabel.text = [item.ingredientName copy];

    if (item.isSelected) {
        self.selectionImageView.image = [UIImage systemImageNamed:@"circle.fill"];
    } else {
        self.selectionImageView.image = [UIImage systemImageNamed:@"circle"];
    }

    [self setupCompletedState];
}

#pragma mark - Private helpers

- (void)setupInProgressState {
    self.stackView.hidden = YES;
}

- (void)setupCompletedState {
    self.stackView.hidden = NO;
}

@end

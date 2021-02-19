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
}

- (void)prepareForReuse {
    [super prepareForReuse];
//    self.nameLabel.text = nil;
}

#pragma mark - Public Interface

+ (NSString *)reuseIdentifier {
    return NSStringFromClass([self class]);
}

- (void)configureWithItem:(IngredientItem *)item {
    assert(nil != item);
    assert(NSThread.isMainThread);

    self.nameLabel.text = [item.ingredientName copy];
}

@end

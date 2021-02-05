//
//  HomeDashboardCell.m
//  Boozter
//
//  Created by Ivan Bukshev on 02/09/2019.
//  Copyright © 2019 Team Absurdum. All rights reserved.
//

#import "HomeDashboardCell.h"
#import "HomeDashboardItem.h"

@interface HomeDashboardCell ()
@property (nonatomic, weak) IBOutlet UIStackView *stackView;
@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@end

@implementation HomeDashboardCell

#pragma mark - Initialization

- (void)awakeFromNib {
    assert(nil != self.imageView);
    assert(nil != self.nameLabel);

    [super awakeFromNib];

    [self setupInProgressState];

    self.imageView.layer.cornerRadius = 16.0f;
    self.imageView.layer.masksToBounds = true;
}

#pragma mark - Public Interface

+ (NSString *)reuseIdentifier {
    return NSStringFromClass([self class]);
}

- (void)configureWithItem:(HomeDashboardItem *)item {
    assert(nil != item);

    self.nameLabel.text = item.coctailName;

    if (nil == item.coctailImageData) {
        self.imageView.image = [UIImage imageNamed:@"CoctailPlaceholder"];
    } else {
        self.imageView.image = [UIImage imageWithData:item.coctailImageData];
    }

    [self setupCompletedState];
}

- (void)prepareForReuse {
    [super prepareForReuse];
    [self setupInProgressState];
}

#pragma mark - Private helpers

- (void)setupInProgressState {
    self.stackView.hidden = YES;
}

- (void)setupCompletedState {
    self.stackView.hidden = NO;
}

@end

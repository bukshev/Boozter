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
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *progressHUD;
@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@end

@implementation HomeDashboardCell

#pragma mark - Initialization

- (void)awakeFromNib {
    [super awakeFromNib];

    [self setupInProgressState];

    self.opaque = NO;
    self.progressHUD.hidesWhenStopped = YES;
}

#pragma mark - Public Interface

+ (NSString *)reuseIdentifier {
    return NSStringFromClass([self class]);
}

- (void)configureWithItem:(HomeDashboardItem *)item {
    assert(nil != item);

    [self setupCompletedState];

    self.imageView.image = [UIImage imageWithData:item.coctailImageData];
    self.nameLabel.text = item.coctailName;
}


- (void)prepareForReuse {
    [super prepareForReuse];
    [self setupInProgressState];
}

#pragma mark - Private helpers

- (void)setupInProgressState {
    self.progressHUD.hidden = NO;
    [self.progressHUD startAnimating];


    self.imageView.image = nil;

    self.imageView.hidden = YES;
    self.nameLabel.hidden = YES;
}

- (void)setupCompletedState {
    [self.progressHUD stopAnimating];

    self.imageView.hidden = NO;
    self.nameLabel.hidden = NO;
}

@end

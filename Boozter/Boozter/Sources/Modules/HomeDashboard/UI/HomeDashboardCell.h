//
//  HomeDashboardCell.h
//  Boozter
//
//  Created by Ivan Bukshev on 02/09/2019.
//  Copyright © 2019 Team Absurdum. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HomeDashboardItem;

NS_ASSUME_NONNULL_BEGIN

@interface HomeDashboardCell : UICollectionViewCell

@property (nonatomic, weak) IBOutlet UIStackView *stackView;
@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;

+ (NSString *)reuseIdentifier;

- (void)configureWithItem:(HomeDashboardItem *)item;

@end

NS_ASSUME_NONNULL_END

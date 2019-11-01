//
//  HomeDashboardCell.h
//  Boozter
//
//  Created by Ivan Bukshev on 02/09/2019.
//  Copyright © 2019 Team Absurdum. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HomeDashboardItem;
@protocol IHomeDashboardCellActionsDelegate;

NS_ASSUME_NONNULL_BEGIN

@interface HomeDashboardCell : UICollectionViewCell

+ (NSString *)reuseIdentifier;

- (void)configureWithItem:(HomeDashboardItem *)item;
- (void)configureImageWithData:(nullable NSData *)imageData;

@end

NS_ASSUME_NONNULL_END

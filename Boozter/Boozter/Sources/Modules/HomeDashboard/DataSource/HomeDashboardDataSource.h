//
//  HomeDashboardDataSource.h
//  Boozter
//
//  Created by Ivan Bukshev on 02/09/2019.
//  Copyright © 2019 Team Absurdum. All rights reserved.
//

#import <UIKit/UICollectionView.h>

@class Coctail;

NS_ASSUME_NONNULL_BEGIN

@interface HomeDashboardDataSource : NSObject <UICollectionViewDataSource>

@property (nonatomic, weak, nullable, readonly) UICollectionView *collectionView;

- (void)injectCollectionView:(UICollectionView *)collectionView;

- (void)updateDataSourceWithCoctails:(NSArray<Coctail *> *)coctails;
- (nullable Coctail *)coctailForIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END

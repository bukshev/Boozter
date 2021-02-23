//
//  HomeDashboardDataSource.h
//  Boozter
//
//  Created by Ivan Bukshev on 02/09/2019.
//  Copyright © 2019 Team Absurdum. All rights reserved.
//

#import <UIKit/UICollectionView.h>

@class Coctail;
@protocol IHomeDashboardCellImageDownloader;

NS_ASSUME_NONNULL_BEGIN

@interface HomeDashboardDataSource : NSObject <UICollectionViewDataSource, UICollectionViewDataSourcePrefetching>

@property (nonatomic, weak, nullable, readonly) UICollectionView *collectionView;

- (void)injectCollectionView:(UICollectionView *)collectionView;
- (void)injectHomeDashboardCellImageDownloader:(id<IHomeDashboardCellImageDownloader>)imageDownloader;

- (void)updateWithCoctails:(NSArray<Coctail *> *)coctails;
- (void)updateImageData:(nullable NSData *)imageData itemIndexPath:(NSIndexPath *)indexPath;

- (nullable Coctail *)coctailForIndexPath:(NSIndexPath *)indexPath;

- (void)collectionView:(UICollectionView *)collectionView
       willDisplayCell:(UICollectionViewCell *)cell
    forItemAtIndexPath:(NSIndexPath *)indexPath;

- (void)collectionView:(UICollectionView *)collectionView
  didEndDisplayingCell:(UICollectionViewCell *)cell
    forItemAtIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END

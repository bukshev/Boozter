//
//  HomeDashboardDataSource.m
//  Boozter
//
//  Created by Ivan Bukshev on 02/09/2019.
//  Copyright © 2019 Team Absurdum. All rights reserved.
//

#import "HomeDashboardDataSource.h"
#import <UIKit/NSIndexPath+UIKitAdditions.h>
#import "HomeDashboardItem.h"
#import "HomeDashboardCell.h"
#import "Coctail.h"
#import "IHomeDashboardCellImageDownloader.h"

static NSUInteger const kNumberOfSections = 1;

@interface HomeDashboardDataSource ()
@property (nonatomic, copy) NSMutableArray<Coctail *> *coctails;
@property (nonatomic, copy) NSMutableArray<HomeDashboardItem *> *items;
@property (nonatomic, weak, nullable) id<IHomeDashboardCellImageDownloader> imageDownloader;
@end

@implementation HomeDashboardDataSource

#pragma mark - Initialization

- (void)injectCollectionView:(UICollectionView *)collectionView {
    assert(nil != collectionView);

    _collectionView = collectionView;
    _collectionView.dataSource = self;
    _collectionView.prefetchDataSource = self;

    UINib *nib = [UINib nibWithNibName:[HomeDashboardCell reuseIdentifier] bundle:nil];
    [_collectionView registerNib:nib forCellWithReuseIdentifier:[HomeDashboardCell reuseIdentifier]];
}

- (void)injectHomeDashboardCellImageDownloader:(id<IHomeDashboardCellImageDownloader>)imageDownloader {
    _imageDownloader = imageDownloader;
}

#pragma mark - Public Interface

- (void)updateDataSourceWithCoctails:(NSArray<Coctail *> *)coctails {
    assert(nil != coctails);

    _coctails = [coctails mutableCopy];
    _items = [NSMutableArray arrayWithCapacity:coctails.count];
    [coctails enumerateObjectsUsingBlock:^(Coctail *obj, NSUInteger idx, BOOL *stop) {
        HomeDashboardItem *item = [[HomeDashboardItem alloc] initWithCoctail:coctails[idx]];
        [self.items addObject:item];
    }];
}

- (void)updateImageData:(NSData *)imageData itemIndexPath:(NSIndexPath *)indexPath {
    HomeDashboardItem *item = self.items[indexPath.row];
    item.coctailImageData = imageData;
}

- (Coctail *)coctailForIndexPath:(NSIndexPath *)indexPath {
    assert(nil != indexPath);
    return self.coctails[indexPath.row];
}

- (void)collectionView:(UICollectionView *)collectionView
       willDisplayCell:(UICollectionViewCell *)dequeuedCell
    forItemAtIndexPath:(NSIndexPath *)indexPath {

    if (!collectionView.isDragging) {
        [self animateCell:dequeuedCell];
    }

    BOOL const isHomeDashboardCell = [dequeuedCell isKindOfClass:[HomeDashboardCell class]];
    if (!isHomeDashboardCell) {
        return;
    }

    HomeDashboardCell *cell = (HomeDashboardCell *)dequeuedCell;
    HomeDashboardItem *item = self.items[indexPath.row];

    [cell configureWithItem:item];

    Coctail *coctail = self.coctails[indexPath.row];
    if (nil == item.coctailImageData) {
        [self.imageDownloader downloadImageFromURL:coctail.imageURL indexPath:indexPath];
    }
}

- (void)collectionView:(UICollectionView *)collectionView
  didEndDisplayingCell:(UICollectionViewCell *)cell
    forItemAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row >= self.items.count) {
        return;
    }

    HomeDashboardItem *item = self.items[indexPath.row];
    if (nil == item.coctailImageData) {
        Coctail *coctail = self.coctails[indexPath.row];
        [self.imageDownloader slowDownImageDownloadingFromURL:coctail.imageURL];
    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return kNumberOfSections;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *const reuseIdentifier = [HomeDashboardCell reuseIdentifier];
    return [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];;
}

#pragma mark - UICollectionViewDataSourcePrefetching

- (void)collectionView:(UICollectionView *)collectionView prefetchItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
    [self executeAsynchronously:^{
        [indexPaths enumerateObjectsUsingBlock:^(NSIndexPath * indexPath, NSUInteger idx, BOOL *stop) {
            HomeDashboardItem *item = self.items[indexPath.row];
            if (nil == item.coctailImageData) {
                Coctail *coctail = self.coctails[indexPath.row];
                [self.imageDownloader downloadImageFromURL:coctail.imageURL indexPath:indexPath];
            }
        }];
    }];
}

- (void)collectionView:(UICollectionView *)collectionView cancelPrefetchingForItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
    [self executeAsynchronously:^{
        [indexPaths enumerateObjectsUsingBlock:^(NSIndexPath *indexPath, NSUInteger idx, BOOL *stop) {
            HomeDashboardItem *item = self.items[indexPath.row];
            if (nil == item.coctailImageData) {
                Coctail *coctail = self.coctails[indexPath.row];
                [self.imageDownloader slowDownImageDownloadingFromURL:coctail.imageURL];
            }
        }];
    }];
}

#pragma mark - Animations

- (void)animateCell:(UICollectionViewCell *)cell {
    cell.alpha = 0.0f;

    [UIView animateWithDuration:0.35f animations:^{
        cell.alpha = 1.0f;
    }];
}

#pragma mark - Optimizations

- (void)executeAsynchronously:(void (^)(void))block {
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0), [block copy]);
}

@end

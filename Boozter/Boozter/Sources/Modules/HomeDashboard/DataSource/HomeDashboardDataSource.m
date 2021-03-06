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
@property (nonatomic, copy) NSArray<Coctail *> *allCoctails;
@property (nonatomic, copy) NSMutableArray<Coctail *> *displayedCoctails;
@property (nonatomic, copy) NSMutableArray<HomeDashboardItem *> *displayedItems;
@property (nonatomic, weak, nullable) id<IHomeDashboardCellImageDownloader> imageDownloader;
@end

@implementation HomeDashboardDataSource

#pragma mark - Initialization

- (instancetype)init {
    self = [super init];

    if (nil != self) {
        _allCoctails = [NSArray array];
        _displayedCoctails = [NSMutableArray<Coctail *> arrayWithCapacity:0];
        _displayedItems = [NSMutableArray<HomeDashboardItem *> arrayWithCapacity:0];
    }

    return self;
}

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

- (void)updateWithCoctails:(NSArray<Coctail *> *)coctails {
    assert(nil != coctails);

    _allCoctails = [coctails copy];
    [self updatePrivateModelsWithCoctails:self.allCoctails];
}

- (void)updateImageData:(NSData *)imageData itemIndexPath:(NSIndexPath *)indexPath {
    assert(nil != imageData);
    assert(nil != indexPath);

    if (indexPath.row >= self.displayedItems.count) {
        return;
    }

    HomeDashboardItem *item = self.displayedItems[indexPath.row];
    item.coctailImageData = imageData;
}

- (void)installAllCoctails {
    if (self.allCoctails.count > 0) {
        [self updatePrivateModelsWithCoctails:self.allCoctails];
    }
}

- (void)installOnlyFavoritedCoctails {
    NSMutableArray *favoritedCoctails = [NSMutableArray arrayWithCapacity:self.displayedCoctails.count];

    for (Coctail *coctail in self.displayedCoctails) {
        if (coctail.isFavorited) {
            [favoritedCoctails addObject:coctail];
        }
    }

    [self updatePrivateModelsWithCoctails:[favoritedCoctails copy]];
}

- (void)updatePrivateModelsWithCoctails:(NSArray<Coctail *> *)coctails {
    _displayedCoctails = [coctails mutableCopy];
    _displayedItems = [NSMutableArray arrayWithCapacity:coctails.count];

    for (Coctail *coctail in self.displayedCoctails) {
        HomeDashboardItem *item = [[HomeDashboardItem alloc] initWithCoctail:coctail];
        [self.displayedItems addObject:item];
    }
}

- (nullable Coctail *)coctailForIndexPath:(NSIndexPath *)indexPath {
    assert(nil != indexPath);

    if (indexPath.row >= self.displayedItems.count) {
        return nil;
    }

    return self.displayedCoctails[indexPath.row];
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
    HomeDashboardItem *item = self.displayedItems[indexPath.row];

    [cell configureWithItem:item];

    Coctail *coctail = self.displayedCoctails[indexPath.row];
    if (nil == item.coctailImageData) {
        [self.imageDownloader downloadImageFromURL:coctail.imageURL indexPath:indexPath];
    }
}

- (void)collectionView:(UICollectionView *)collectionView
  didEndDisplayingCell:(UICollectionViewCell *)cell
    forItemAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row >= self.displayedItems.count) {
        return;
    }

    HomeDashboardItem *item = self.displayedItems[indexPath.row];
    if (nil == item.coctailImageData) {
        Coctail *coctail = self.displayedCoctails[indexPath.row];
        [self.imageDownloader slowDownImageDownloadingFromURL:coctail.imageURL];
    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return kNumberOfSections;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.displayedItems.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *const reuseIdentifier = [HomeDashboardCell reuseIdentifier];
    return [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];;
}

#pragma mark - UICollectionViewDataSourcePrefetching

- (void)collectionView:(UICollectionView *)collectionView prefetchItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
    [self executeAsynchronously:^{
        for (NSIndexPath *indexPath in indexPaths) {
            if (indexPath.row >= self.displayedItems.count) {
                return;
            }
            HomeDashboardItem *item = self.displayedItems[indexPath.row];
            if (nil == item.coctailImageData) {
                Coctail *coctail = self.displayedCoctails[indexPath.row];
                [self.imageDownloader downloadImageFromURL:coctail.imageURL indexPath:indexPath];
            }
        }
    }];
}

- (void)collectionView:(UICollectionView *)collectionView cancelPrefetchingForItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
    [self executeAsynchronously:^{
        for (NSIndexPath *indexPath in indexPaths) {
            if (indexPath.row >= self.displayedItems.count) {
                return;
            }
            HomeDashboardItem *item = self.displayedItems[indexPath.row];
            if (nil == item.coctailImageData) {
                Coctail *coctail = self.displayedCoctails[indexPath.row];
                [self.imageDownloader slowDownImageDownloadingFromURL:coctail.imageURL];
            }
        }
    }];
}

#pragma mark - Animations

- (void)animateCell:(UICollectionViewCell *)cell {
    cell.alpha = 0.0f;

    [UIView animateWithDuration:0.55f animations:^{
        cell.alpha = 1.0f;
    }];
}

#pragma mark - Optimizations

- (void)executeAsynchronously:(void (^)(void))block {
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0), [block copy]);
}

@end

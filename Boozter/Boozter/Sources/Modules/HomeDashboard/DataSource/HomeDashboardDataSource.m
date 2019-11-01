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

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return kNumberOfSections;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *const reuseIdentifier = [HomeDashboardCell reuseIdentifier];
    UICollectionViewCell *dequeuedCell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier
                                                                                   forIndexPath:indexPath];

    if (![dequeuedCell isKindOfClass:[HomeDashboardCell class]]) {
        return [[UICollectionViewCell alloc] init];
    }

    __block HomeDashboardCell *cell = (HomeDashboardCell *)dequeuedCell;
    HomeDashboardItem *item = self.items[indexPath.row];

    [cell configureWithItem:item];

    Coctail *coctail = self.coctails[indexPath.row];
    if (nil == item.coctailImageData) {
        [self.imageDownloader downloadImageFromURL:coctail.imageURL indexPath:indexPath];
    }

    return cell;
}

@end

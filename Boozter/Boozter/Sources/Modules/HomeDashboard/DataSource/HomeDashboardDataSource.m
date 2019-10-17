//
//  HomeDashboardDataSource.m
//  Boozter
//
//  Created by Ivan Bukshev on 02/09/2019.
//  Copyright © 2019 Team Absurdum. All rights reserved.
//

#import "HomeDashboardDataSource.h"
#import "HomeDashboardItem.h"
#import "HomeDashboardCell.h"

static NSUInteger const kNumberOfSections = 1;

@interface HomeDashboardDataSource ()
@property (nonatomic, copy) NSMutableArray<Coctail *> *coctails;
@property (nonatomic, copy) NSMutableArray<HomeDashboardItem *> *items;
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

#pragma mark - Public Interface

- (void)updateDataSourceWithCoctails:(NSArray<Coctail *> *)coctails {
    assert(nil != coctails);

    _coctails = [coctails copy];
    _items = [NSMutableArray arrayWithCapacity:coctails.count];
    [coctails enumerateObjectsUsingBlock:^(Coctail *obj, NSUInteger idx, BOOL *stop) {
        HomeDashboardItem *item = [[HomeDashboardItem alloc] initWithCoctail:coctails[idx]];
        [self.items addObject:item];
    }];
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

    UICollectionViewCell *dequeuedCell = nil;
    dequeuedCell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier
                                                             forIndexPath:indexPath];

    if (![dequeuedCell isKindOfClass:[HomeDashboardCell class]]) {
        return [[UICollectionViewCell alloc] init];
    }

    HomeDashboardCell *cell = (HomeDashboardCell *)dequeuedCell;
    HomeDashboardItem *item = self.items[indexPath.row];

    [cell configureWithItem:item];

    return cell;
}

@end

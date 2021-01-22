//
//  HomeDashboardViewController.m
//  Boozter
//
//  Created by Ivan Bukshev on 02/09/2019.
//  Copyright © 2019 Team Absurdum. All rights reserved.
//

#import "HomeDashboardViewController.h"
#import "IHomeDashboardViewOutput.h"
#import "HomeDashboardDataSource.h"

@interface HomeDashboardViewController () <UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) HomeDashboardDataSource *dataSource;
@end

@implementation HomeDashboardViewController

#pragma mark - Initialization

- (void)injectOutput:(id<IHomeDashboardViewOutput>)output {
    assert(nil != output);
    _output = output;
}

- (void)injectDataSource:(HomeDashboardDataSource *)dataSource {
    assert(nil != dataSource);
    _dataSource = dataSource;
}

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    CGSize const screenSize = [UIScreen mainScreen].bounds.size;
    [self.output onViewReadyEvent:screenSize];
}

#pragma mark - IHomeDashboardViewInput

- (void)setupInitialState {
    self.title = @"Коктейли";

    self.view.opaque = NO;
    self.view.backgroundColor = [UIColor systemGroupedBackgroundColor];

    self.collectionView.opaque = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.backgroundColor = [UIColor systemGroupedBackgroundColor];

    [self.dataSource injectCollectionView:self.collectionView];
}

- (void)reloadData {
    assert(NSThread.isMainThread);

    [self.collectionView reloadData];
}

- (void)reloadItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
    assert(nil != indexPaths);
    assert(NSThread.isMainThread);

    [self.collectionView reloadItemsAtIndexPaths:indexPaths];
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.output didSelectItemAtIndexPath:indexPath];
}

- (void)collectionView:(UICollectionView *)collectionView
       willDisplayCell:(UICollectionViewCell *)cell
    forItemAtIndexPath:(NSIndexPath *)indexPath {

    [self.dataSource collectionView:collectionView willDisplayCell:cell forItemAtIndexPath:indexPath];
}

- (void)collectionView:(UICollectionView *)collectionView
  didEndDisplayingCell:(UICollectionViewCell *)cell
    forItemAtIndexPath:(NSIndexPath *)indexPath {

    [self.dataSource collectionView:collectionView didEndDisplayingCell:cell forItemAtIndexPath:indexPath];
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    return [self.output sizeForItemAtIndexPath:indexPath];
}

@end

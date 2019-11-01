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
// UI Outlets.
@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
// UI data management.
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
    [self.output onViewReadyEvent];
}

#pragma mark - IHomeDashboardViewInput

- (void)setupInitialState {
    self.title = @"Коктейли";
    [self.dataSource injectCollectionView:self.collectionView];
}

- (void)reloadData {
    [self.collectionView reloadData];
}

- (void)reloadItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
    [self.collectionView reloadItemsAtIndexPaths:indexPaths];
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.output didSelectItemAtIndexPath:indexPath];
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    CGSize const screenSize = [UIScreen mainScreen].bounds.size;
    return [self.output sizeForItemAtIndexPath:indexPath screenSize:screenSize];
}

@end

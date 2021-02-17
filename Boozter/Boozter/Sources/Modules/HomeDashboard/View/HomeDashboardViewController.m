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

#import "UIColor+Application.h"
#import "UINavigationController+StatusBarColor.h"

@interface HomeDashboardViewController () <UISearchControllerDelegate, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) HomeDashboardDataSource *dataSource;
@property (nonatomic, strong) UIVisualEffectView *blurEffectView;
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
    assert(nil != self.output);

    [super viewDidLoad];

    CGSize const screenSize = [UIScreen mainScreen].bounds.size;
    [self.output onViewReadyEvent:screenSize];
}

#pragma mark - IHomeDashboardViewInput

- (void)setupInitialState {
    assert(nil != self.collectionView);
    assert(nil != self.dataSource);

    [self.navigationController setStatusBarColor:[UIColor navigationControllerBackgroundColor]];

    [self.dataSource injectCollectionView:self.collectionView];
    [self setupSearchBar];
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

- (void)showBlurEffect {
    assert(NSThread.isMainThread);

    if (UIAccessibilityIsReduceTransparencyEnabled()) {
        return;
    }

    if (nil == _blurEffectView) {
        self.view.backgroundColor = [UIColor clearColor];

        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        self.blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];

        self.blurEffectView.frame = self.view.bounds;
        self.blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }

    self.blurEffectView.alpha = 1.0f;
    self.blurEffectView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);

    self.collectionView.userInteractionEnabled = NO;
    [self.view addSubview:self.blurEffectView];
}

- (void)hideBlurEffect {
    assert(NSThread.isMainThread);

    if (UIAccessibilityIsReduceTransparencyEnabled()) {
        return;
    }

    [UIView animateWithDuration:0.55 animations:^{
        self.blurEffectView.alpha = 0.0f;
        self.blurEffectView.transform = CGAffineTransformMakeScale(0.25f, 0.25f);
    } completion:^(BOOL finished) {
        [self.blurEffectView removeFromSuperview];
        self.collectionView.userInteractionEnabled = YES;
    }];
}

#pragma mark - UISearchControllerDelegate

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

#pragma mark - Private helpers

- (void)setupSearchBar {

    UISearchController *searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    searchController.delegate = self;

    UISearchBar *searchBar = searchController.searchBar;
    searchBar.tintColor = [UIColor blackColor];
    searchBar.barTintColor = [UIColor blackColor];


    UITextField *searchBarTextField = [searchBar valueForKey:@"searchField"];
    if (nil != searchBarTextField) {
        searchBarTextField.textColor = [UIColor blackColor];

        UIView *backgroundView = [searchBarTextField.subviews firstObject];
        if (nil != backgroundView) {
            backgroundView.backgroundColor = [UIColor whiteColor];
            backgroundView.layer.cornerRadius = 10.0f;
            backgroundView.clipsToBounds = YES;
        }
    }

//    self.navigationController.navigationBar.barTintColor = blue

    self.navigationItem.searchController = searchController;
//    self.navigationItem.hidesSearchBarWhenScrolling = NO;
}

@end

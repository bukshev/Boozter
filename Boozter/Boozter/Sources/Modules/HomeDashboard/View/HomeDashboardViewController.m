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

@interface HomeDashboardViewController () <UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, weak) IBOutlet UIView *favoritesContainerView;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *favoritesContainerHeight;
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

#pragma mark - User Actions

- (IBAction)onSelectFavoritesBarButtonItemTap:(UIBarButtonItem *)sender {
    if (0.0f == self.favoritesContainerHeight.constant) {
        [self showFavoritesContainer];
    } else {
        [self hideFavoritesContainer];
    }
}

- (IBAction)onSelectFilterBarButtonItemTap:(UIBarButtonItem *)sender {
    [self.output onSelectFilter];
}

- (IBAction)onFavoritesSegmentedControlValueChanged:(UISegmentedControl *)sender {
    [self.output onSelectFavoritesSegmentIndex:sender.selectedSegmentIndex];
}

#pragma mark - IHomeDashboardViewInput

- (void)setupInitialState {
    assert(nil != self.collectionView);
    assert(nil != self.dataSource);
    assert(NSThread.isMainThread);

    [self hideFavoritesContainer];

    [self.dataSource injectCollectionView:self.collectionView];

    if (@available(iOS 13, *)) {
        UINavigationBarAppearance *appearance = [[UINavigationBarAppearance alloc] init];
        [appearance configureWithOpaqueBackground];
        appearance.backgroundColor = [UIColor navigationControllerBackgroundColor];
        self.navigationController.navigationBar.standardAppearance = appearance;
        self.navigationController.navigationBar.scrollEdgeAppearance = appearance;
//        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
//        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    } else {
        [self.navigationController setStatusBarColor:[UIColor navigationControllerBackgroundColor]];
    }
}

- (void)setTitle:(NSString *)title {
    assert(nil != title);
    assert(NSThread.isMainThread);

    self.navigationItem.title = [title copy];
}

- (void)reloadData {
    assert(NSThread.isMainThread);

    [self.collectionView performBatchUpdates:^{
        [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
    } completion:^(BOOL finished) {

    }];
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

    [UIView animateWithDuration:0.25 animations:^{
        self.blurEffectView.alpha = 0.0f;
        self.blurEffectView.transform = CGAffineTransformMakeScale(0.25f, 0.25f);
    } completion:^(BOOL finished) {
        [self.blurEffectView removeFromSuperview];
        self.collectionView.userInteractionEnabled = YES;
    }];
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

#pragma mark - Private animations

- (void)showFavoritesContainer {
    [self.view layoutIfNeeded];

    [UIView animateWithDuration:0.35f animations:^{
        self.favoritesContainerHeight.constant = 64.0f;
        self.favoritesContainerView.alpha = 1.0;
        [self.view layoutIfNeeded];
    }];
}

- (void)hideFavoritesContainer {
    [self.view layoutIfNeeded];

    [UIView animateWithDuration:0.35f animations:^{
        self.favoritesContainerHeight.constant = 0.0f;
        self.favoritesContainerView.alpha = 0.0;
        [self.view layoutIfNeeded];
    }];
}

@end

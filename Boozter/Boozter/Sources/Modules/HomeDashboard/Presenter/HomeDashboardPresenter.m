//
//  HomeDashboardPresenter.m
//  Boozter
//
//  Created by Ivan Bukshev on 02/09/2019.
//  Copyright © 2019 Team Absurdum. All rights reserved.
//

#import "HomeDashboardPresenter.h"
#import "IHomeDashboardCellImageDownloader.h"

#import "IHomeDashboardViewInput.h"
#import "IProgressIndication.h"
#import "IHomeDashboardInteractorInput.h"
#import "IHomeDashboardRouterInput.h"

#import "Coctail.h"
#import "Ingredient.h"
#import "IngredientsFilter.h"
#import "HomeDashboardDataSource.h"
#import "IImageDownloader.h"

typedef NS_ENUM(NSUInteger, FilterSegmentIndex) {
    FilterSegmentIndexAll,
    FilterSegmentIndexFavorited
};

static CGFloat const kSecondsDelayBeforeShowingView = 1.35f;
static CGFloat const kSecondsDelayAfterSwitchingSegmentedControl = 0.15f;

@interface HomeDashboardPresenter () <IHomeDashboardCellImageDownloader>
@property (nonatomic, strong) id<IImageDownloader> imageDownloader;
@property (nonatomic, weak) HomeDashboardDataSource *dataSource;
@property (nonatomic, assign) CGSize coctailCellSize;
@property (nonatomic, strong, nullable) IngredientsFilter *ingredientsFilter;
@end

@implementation HomeDashboardPresenter

#pragma mark - Initialization

- (instancetype)initWithInteractor:(id<IHomeDashboardInteractorInput>)interactor
                            router:(id<IHomeDashboardRouterInput>)router
                   imageDownloader:(id<IImageDownloader>)imageDownloader {

    assert(nil != interactor);
    assert(nil != router);
    assert(nil != imageDownloader);

    self = [super init];

    if (nil != self) {
        _interactor = interactor;
        _router = router;
        _coctailCellSize = CGSizeZero;
        _imageDownloader = imageDownloader;
    }

    return self;
}

- (void)injectView:(id<IHomeDashboardViewInput, IProgressIndication>)view {
    assert(nil != view);

    _view = view;
}

- (void)injectDataSource:(HomeDashboardDataSource *)dataSource {
    assert(nil != dataSource);

    _dataSource = dataSource;
    [_dataSource injectHomeDashboardCellImageDownloader:self];
}

#pragma mark - IHomeDashboardViewOutput

- (void)onViewReadyEvent:(CGSize)screenSize {
    _coctailCellSize = [self coctailCellSizeForScreenSize:screenSize];

    Ingredient *defaultIngredient = [Ingredient defaultIngredient];

    [self.view setupInitialState];
    [self.view setTitle:[NSString stringWithFormat:@"Coctails with %@", defaultIngredient.name]];

    [self.view showBlurEffect];
    [self.view showProgressHUD:@"Loading cocktails data..."];


    [self.interactor obtainRemoteCoctailsWithIngredient:defaultIngredient];
}

- (void)onSelectFilter {
    [self.router openIngredientsScreenWithModuleOutput:self];
}

- (void)onSelectFavoritesSegmentIndex:(NSInteger)selectedSegmentIndex {
    [self.view showBlurEffect];

    switch (selectedSegmentIndex) {
        case FilterSegmentIndexAll:
            [self.dataSource installAllCoctails];
            break;
        case FilterSegmentIndexFavorited:
            [self.dataSource installOnlyFavoritedCoctails];
            break;
        default:
            NSAssert(NO, @"Unsupported segment index: %ld", selectedSegmentIndex);
    }

    dispatch_async(dispatch_get_main_queue(), ^{
        [self.view reloadData];
        [self hideBlurViewAfterLoadingAfterDelay:kSecondsDelayAfterSwitchingSegmentedControl];
    });
}

- (void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    assert(nil != indexPath);

    Coctail *tappedCoctail = [self.dataSource coctailForIndexPath:indexPath];
    [self.router openDetailScreenWithCoctail:tappedCoctail];
}

- (CGSize)sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    assert(CGSizeZero.height != self.coctailCellSize.height);
    assert(CGSizeZero.width != self.coctailCellSize.width);

    return self.coctailCellSize;
}

#pragma mark - IHomeDashboardInteractorOutput

- (void)didObtainCoctails:(NSArray<Coctail *> *)coctails {
    assert(nil != coctails);

    [self.imageDownloader invalidateCache];
    [self.dataSource updateWithCoctails:coctails];

    dispatch_async(dispatch_get_main_queue(), ^{
        [self.view reloadData];
        [self hideBlurViewAfterLoadingAfterDelay:kSecondsDelayBeforeShowingView];
    });
}

- (void)didFailObtainCoctailsWithError:(NSError *)error {
    assert(nil != error);

    // TODO: Hide progress HUD in main thread and show alert with failure reason.
    [self hideBlurViewAfterLoadingAfterDelay:kSecondsDelayBeforeShowingView];
}

#pragma mark - IHomeDashboardCellImageDownloader

- (void)downloadImageFromURL:(NSURL *)url indexPath:(NSIndexPath *)indexPath {
    assert(nil != indexPath);

    [self.imageDownloader downloadImageFromURL:url
                                     indexPath:indexPath
                             completionHandler:[self imageDownloadCompletion]];
}

- (void)slowDownImageDownloadingFromURL:(NSURL *)url {
    [self.imageDownloader slowDownImageDownloadingFromURL:url];
}

#pragma mark - IIngredientsModuleOutput

- (void)didSetFilter:(IngredientsFilter *)filter {
    assert(nil != filter);

    self.ingredientsFilter = filter;

    Ingredient *ingredient = [filter.ingredients anyObject];
    if (nil != ingredient) {
        [self.view showBlurEffect];
        [self.view showProgressHUD:@"Loading cocktails data..."];
        [self.view setTitle:[NSString stringWithFormat:@"Coctails with %@", ingredient.name]];
        [self.interactor obtainRemoteCoctailsWithIngredient:ingredient];
    } else {
        // TODO: Process error.
        // Note: Always occurred when we return from 'Ingredients' screen without selected ingredient.
        NSLog(@"Case without implementation in: %s", __PRETTY_FUNCTION__);
    }
}

#pragma mark - Private helpers

- (void)hideBlurViewAfterLoadingAfterDelay:(CGFloat)delay {
    dispatch_time_t deadline = dispatch_time(DISPATCH_TIME_NOW, delay * NSEC_PER_SEC);
    dispatch_after(deadline, dispatch_get_main_queue(), ^{
        [self.view hideProgressHUD];
        [self.view hideBlurEffect];
    });
}

- (CGSize)coctailCellSizeForScreenSize:(CGSize)screenSize {
    assert(CGSizeZero.height != screenSize.height);
    assert(CGSizeZero.width != screenSize.width);

    CGFloat const indent = 16;
    CGFloat const width = (screenSize.width / 2.0f) - (indent * 2.0f);
    CGFloat const height = width * 1.2f;

    return CGSizeMake(width, height);
}

- (ImageForIndexPathDownloadCompletion)imageDownloadCompletion {
    __weak typeof(self) weakSelf = self;

    ImageForIndexPathDownloadCompletion handler = ^(NSData *data, NSURL *url, NSIndexPath *indexPath, NSError *error) {
        typeof(self) strongSelf = weakSelf;
        if (nil == strongSelf) {
            return;
        }

        if (nil != error) {
            [strongSelf didFailDownloadImageDataWithError:error];
        } else {
            [strongSelf didDownloadImageData:data indexPath:indexPath];
        }
    };

    return [handler copy];
}

- (void)didDownloadImageData:(NSData *)imageData indexPath:(NSIndexPath *)indexPath {
    assert(nil != imageData);
    assert(nil != indexPath);

    [self.dataSource updateImageData:imageData itemIndexPath:indexPath];

    dispatch_async(dispatch_get_main_queue(), ^{
        [self.view reloadItemsAtIndexPaths:@[indexPath]];
    });
}

- (void)didFailDownloadImageDataWithError:(NSError *)error {
    assert(nil != error);

    // TODO: Set placeholder image.
}

@end

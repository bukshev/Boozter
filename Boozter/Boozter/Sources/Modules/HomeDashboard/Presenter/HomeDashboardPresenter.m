//
//  HomeDashboardPresenter.m
//  Boozter
//
//  Created by Ivan Bukshev on 02/09/2019.
//  Copyright © 2019 Team Absurdum. All rights reserved.
//

#import "HomeDashboardPresenter.h"
#import "IHomeDashboardCellImageDownloader.h"
//
#import "IHomeDashboardViewInput.h"
#import "IProgressIndication.h"
#import "IHomeDashboardInteractorInput.h"
#import "IHomeDashboardRouterInput.h"
//
#import "Coctail.h"
#import "HomeDashboardDataSource.h"

@interface HomeDashboardPresenter () <IHomeDashboardCellImageDownloader>
@property (nonatomic, weak) HomeDashboardDataSource *dataSource;
@property (nonatomic, assign) CGSize coctailCellSize;
@end

@implementation HomeDashboardPresenter

#pragma mark - Initialization

- (instancetype)initWithInteractor:(id<IHomeDashboardInteractorInput>)interactor
                            router:(id<IHomeDashboardRouterInput>)router {
    assert(nil != interactor);
    assert(nil != router);

    self = [super init];

    if (nil != self) {
        _interactor = interactor;
        _router = router;
        _coctailCellSize = CGSizeZero;
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

    [self.view setupInitialState];
    [self.view showProgressHUD];

    [self.interactor obtainCoctailsFromSourcePoint:DataSourcePointRemote
                                        withFilter:CoctailsFilterNone];
}

- (void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    assert(nil != indexPath);

    Coctail *tappedCoctail = [self.dataSource coctailForIndexPath:indexPath];
    [self.router openDetailScreenWithCoctail:tappedCoctail];
}

- (void)willDisplayCellForItemAtIndexPath:(NSIndexPath *)indexPath {
    assert(nil != indexPath);

    Coctail *coctail = [self.dataSource coctailForIndexPath:indexPath];
    [self.interactor downloadImageFromURL:coctail.imageURL indexPath:indexPath];
}

- (CGSize)sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    assert(CGSizeZero.height != self.coctailCellSize.height);
    assert(CGSizeZero.width != self.coctailCellSize.width);

    return self.coctailCellSize;
}

#pragma mark - IHomeDashboardInteractorOutput

- (void)didObtainCoctails:(NSArray<Coctail *> *)coctails {
    assert(nil != coctails);

    [self.dataSource updateDataSourceWithCoctails:coctails];

    dispatch_async(dispatch_get_main_queue(), ^{
        [self.view hideProgressHUD];
        [self.view reloadData];
    });
}

- (void)didFailObtainCoctailsWithError:(NSError *)error {
    assert(nil != error);
    
    // TODO: Hide progress HUD in main thread and show alert with failure reason.
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

#pragma mark - IHomeDashboardCellImageDownloader

- (void)downloadImageFromURL:(NSURL *)url indexPath:(NSIndexPath *)indexPath {
    assert(nil != indexPath);

    [self.interactor downloadImageFromURL:url indexPath:indexPath];
}

- (void)slowDownImageDownloadingFromURL:(NSURL *)url {
    [self.interactor slowDownImageDownloadingFromURL:url];
}

#pragma mark - Private helpers

- (CGSize)coctailCellSizeForScreenSize:(CGSize)screenSize {
    assert(CGSizeZero.height != screenSize.height);
    assert(CGSizeZero.width != screenSize.width);

    CGFloat const indent = 16.0f;
    CGFloat const width = (screenSize.width / 2.0f) - (indent * 2.0f);
    CGFloat const height = width * 1.6f;

    return CGSizeMake(width, height);
}

@end

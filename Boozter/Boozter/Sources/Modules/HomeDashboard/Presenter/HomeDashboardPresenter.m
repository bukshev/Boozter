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

- (void)onViewReadyEvent {
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

- (CGSize)sizeForItemAtIndexPath:(NSIndexPath *)indexPath screenSize:(CGSize)screenSize {
    assert(nil != indexPath);

    CGFloat const indent = 16.0;
    CGFloat const width = (screenSize.width / 2.0) - (indent * 2.0);
    CGFloat const height = width * 1.6;

    return CGSizeMake(width, height);
}

#pragma mark - IHomeDashboardInteractorOutput

- (void)didObtainCoctails:(NSArray<Coctail *> *)coctails {
    assert(nil != coctails);

    __weak typeof(self) weakSelf = self;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        typeof(self) strongSelf = weakSelf;

        if (nil == strongSelf) {
            NSAssert(YES, @"Presenter is nil in %s", __PRETTY_FUNCTION__);
            return;
        }

        [strongSelf.dataSource updateDataSourceWithCoctails:coctails];

        [strongSelf.view hideProgressHUD];
        [strongSelf.view reloadData];
    });
}

- (void)didFailObtainCoctailsWithError:(NSError *)error {
    assert(nil != error);
    // TODO: Hide progress HUD in main thread and show alert with failure reason.
}

- (void)didDownloadImageData:(NSData *)imageData indexPath:(NSIndexPath *)indexPath {
    assert(nil != imageData);
    assert(nil != indexPath);

    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        typeof(self) strongSelf = weakSelf;

        if (nil == strongSelf) {
            NSAssert(YES, @"Presenter is nil in %s", __PRETTY_FUNCTION__);
            return;
        }

        [strongSelf.dataSource updateImageData:imageData itemIndexPath:indexPath];
        [strongSelf.view reloadItemsAtIndexPaths:@[indexPath]];
    });
}

- (void)didFailDownloadImageDataWithError:(NSError *)error {
    assert(nil != error);
}

#pragma mark - IHomeDashboardCellImageDownloader

- (void)downloadImageFromURL:(NSURL *)url indexPath:(NSIndexPath *)indexPath {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self.interactor downloadImageFromURL:url indexPath:indexPath];
    });
}

@end

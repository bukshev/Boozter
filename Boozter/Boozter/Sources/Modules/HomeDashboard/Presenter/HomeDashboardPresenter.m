//
//  HomeDashboardPresenter.m
//  Boozter
//
//  Created by Ivan Bukshev on 02/09/2019.
//  Copyright © 2019 Team Absurdum. All rights reserved.
//

#import "HomeDashboardPresenter.h"
//
#import "IHomeDashboardViewInput.h"
#import "IHomeDashboardInteractorInput.h"
#import "IHomeDashboardRouterInput.h"
//
#import "Coctail.h"
#import "HomeDashboardDataSource.h"

@interface HomeDashboardPresenter ()
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

- (void)injectView:(id<IHomeDashboardViewInput>)view {
    assert(nil != view);
    _view = view;
}

- (void)injectDataSource:(HomeDashboardDataSource *)dataSource {
    assert(nil != dataSource);
    _dataSource = dataSource;
}

#pragma mark - IHomeDashboardViewOutput

- (void)onViewReadyEvent {
    [self.view setupInitialState];
    // TODO: Show progress HUD here.
    [self.interactor obtainCoctailsFromSourcePoint:DataSourcePointCache
                                        withFilter:CoctailsFilterNone];
}

- (void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    assert(nil != indexPath);
    Coctail *tappedCoctail = [self.dataSource coctailForIndexPath:indexPath];

    assert(nil != tappedCoctail);
    [self.router openDetailScreenWithCoctail:tappedCoctail];
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
    [self.dataSource updateDataSourceWithCoctails:coctails];
    // TODO: Hide progress HUD in main thread and update view.
    [self.view reloadData];
}

- (void)didFailObtainCoctailsWithError:(NSError *)error {
    assert(nil != error);
    // TODO: Hide progress HUD in main thread and show alert with failure reason.
}

@end

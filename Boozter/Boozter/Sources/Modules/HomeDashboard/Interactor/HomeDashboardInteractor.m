//
//  HomeDashboardInteractor.m
//  Boozter
//
//  Created by Ivan Bukshev on 02/09/2019.
//  Copyright © 2019 Team Absurdum. All rights reserved.
//

#import "HomeDashboardInteractor.h"
#import "IHomeDashboardInteractorOutput.h"
#import "ICoctailsService.h"

#import "Coctail.h"

@interface HomeDashboardInteractor ()
@property (nonatomic, strong) id<ICoctailsService> coctailsService;
@end

@implementation HomeDashboardInteractor

#pragma mark - Initialization

- (instancetype)initWithCoctailsService:(id<ICoctailsService>)coctailsService {
    assert(nil != coctailsService);

    self = [super init];

    if (nil != self) {
        _coctailsService = coctailsService;
    }

    return self;
}

- (void)injectOutput:(id<IHomeDashboardInteractorOutput>)output {
    assert(nil != output);
    _output = output;
}

#pragma mark - IHomeDashboardInteractorInput

- (void)obtainCoctailsFromSourcePoint:(DataSourcePoint)sourcePoint withFilter:(CoctailsFilter)filter {
    NSPredicate *predicate = [self predicateFromFilter:filter];
    CoctailsServiceObtainingCompletion completionHandler = [self obtainingCompletionHandler];

    [self.coctailsService obtainCoctailsFromSourcePoint:sourcePoint
                                          withPredicate:predicate
                                      completionHandler:completionHandler];
}

- (void)downloadImageFromURL:(NSURL *)url indexPath:(NSIndexPath *)indexPath {
    assert(nil != url);

    __weak typeof(self) weakSelf = self;
    [self.coctailsService downloadImageFromURL:url indexPath:indexPath completionHandler:^(NSData *imageData, NSURL *url, NSIndexPath *indexPath, NSError *error) {
        typeof(self) strongSelf = weakSelf;

        if (nil == strongSelf) {
            NSAssert(YES, @"Interactor is nil in %s", __PRETTY_FUNCTION__);
            return;
        }

        if (nil != error) {
            [strongSelf.output didFailDownloadImageDataWithError:error];
            return;
        }
        
        [strongSelf.output didDownloadImageData:imageData indexPath:indexPath];
    }];
}

#pragma mark - Private helpers

- (nullable NSPredicate *)predicateFromFilter:(CoctailsFilter)filter {
    NSPredicate *predicate = nil;

    switch (filter) {
        case CoctailsFilterNone: {
            predicate = nil;
            break;
        }
        case CoctailsFilterAlcohol: {
            predicate = nil;
            break;
        }
        case CoctailsFilterNoAlcohol: {
            predicate = nil;
            break;
        }
    }

    return predicate;
}

- (CoctailsServiceObtainingCompletion)obtainingCompletionHandler {
    __weak typeof(self) weakSelf = self;

    CoctailsServiceObtainingCompletion completionHandler = ^(NSArray<Coctail *> *coctails, NSError *error) {
        typeof(self) strongSelf = weakSelf;

        if (nil == strongSelf) {
            NSAssert(YES, @"Interactor is nil in %s", __PRETTY_FUNCTION__);
            return;
        }

        if (nil == error && nil != coctails) {
            [strongSelf.output didObtainCoctails:coctails];
        } else if (nil != error) {
            [strongSelf.output didFailObtainCoctailsWithError:error];
        } else {
            NSAssert(false, @"Unexpected behaviour in %s.", __PRETTY_FUNCTION__);
        }
    };

    return [completionHandler copy];
}

@end

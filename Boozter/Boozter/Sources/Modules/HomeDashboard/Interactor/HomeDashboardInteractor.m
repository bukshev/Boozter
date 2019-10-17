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
    switch (sourcePoint) {
        case DataSourcePointCache: {
            [self obtainCachedCoctailsWithFilter:filter];
            break;
        }
        case DataSourcePointRemote: {
            [self obtainRemoteCoctailsWithFilter:filter];
            break;
        }
    }
}

- (void)addStubCoctails {
    Coctail *c = [[Coctail alloc] initWithUUID:[NSUUID UUID]
                                          name:@"12345"
                                      imageURL:nil];
    [self.coctailsService cacheCoctails:@[c]];
}

#pragma mark - Private helpers

- (void)obtainCachedCoctailsWithFilter:(CoctailsFilter)filter {
    NSPredicate *predicate = [self predicateFromFilter:filter];
    CoctailsServiceObtainingCallback callback = [self obtainingCallback];
    [self.coctailsService obtainCachedCoctailsWithPredicate:predicate callback:callback];
}

- (void)obtainRemoteCoctailsWithFilter:(CoctailsFilter)filter {
    assert(YES);
}

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

- (CoctailsServiceObtainingCallback)obtainingCallback {
    __weak typeof(self) weakSelf = self;

    CoctailsServiceObtainingCallback callback = ^(NSArray<Coctail *> *coctails, NSError *error) {
        typeof(self) strongSelf = weakSelf;

        if (nil == strongSelf) {
            NSAssert(YES, @"Interactor is nil in %s", __PRETTY_FUNCTION__);
            return;
        }

        if (nil == error && nil != coctails) {
            [self.output didObtainCoctails:coctails];
        } else if (nil != error) {
            [self.output didFailObtainCoctailsWithError:error];
        } else {
            NSAssert(false, @"Unexpected behaviour in %s.", __PRETTY_FUNCTION__);
        }
    };

    return [callback copy];
}

@end

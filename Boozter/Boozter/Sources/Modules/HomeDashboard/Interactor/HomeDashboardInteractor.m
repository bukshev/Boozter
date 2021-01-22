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
    [self.coctailsService obtainCoctailsFromSourcePoint:sourcePoint
                                          withPredicate:[self predicateFromFilter:filter]
                                      completionHandler:[self coctailsServiceObtainingCompletion]];
}

- (void)downloadImageFromURL:(NSURL *)url indexPath:(NSIndexPath *)indexPath {
    assert(nil != indexPath);

    [self.coctailsService downloadImageFromURL:url
                                     indexPath:indexPath
                             completionHandler:[self imageDownloadCompletion]];
}

- (void)slowDownImageDownloadingFromURL:(NSURL *)url {
    [self.coctailsService slowDownImageDownloadingFromURL:url];
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

- (CoctailsServiceObtainingCompletion)coctailsServiceObtainingCompletion {
    __weak typeof(self) weakSelf = self;

    CoctailsServiceObtainingCompletion handler = ^(NSArray<Coctail *> *coctails, NSError *error) {
        typeof(self) strongSelf = weakSelf;
        if (nil == strongSelf) {
            return;
        }

        if (nil != error) {
            [strongSelf.output didFailObtainCoctailsWithError:error];
        } else if (nil != coctails) {
            [strongSelf.output didObtainCoctails:coctails];
        } else {
            NSAssert(false, @"Unexpected behaviour in %s. 'coctails' and 'error' are nil.", __PRETTY_FUNCTION__);
        }
    };

    return [handler copy];
}

- (ImageDownloadCompletion)imageDownloadCompletion {
    __weak typeof(self) weakSelf = self;

    ImageDownloadCompletion handler = ^(NSData *data, NSURL *url, NSIndexPath *indexPath, NSError *error) {
        typeof(self) strongSelf = weakSelf;
        if (nil == strongSelf) {
            return;
        }

        if (nil != error) {
            [strongSelf.output didFailDownloadImageDataWithError:error];
        } else {
            [strongSelf.output didDownloadImageData:data indexPath:indexPath];
        }
    };

    return [handler copy];
}

@end

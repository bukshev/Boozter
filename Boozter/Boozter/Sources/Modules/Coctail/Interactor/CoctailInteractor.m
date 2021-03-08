//
//  CoctailInteractor.m
//  Boozter
//
//  Created by Букшев Иван Евгеньевич on 03.02.2021.
//  Copyright © 2021 Team Absurdum. All rights reserved.
//

#import "CoctailInteractor.h"
#import "ICoctailInteractorOutput.h"
#import "ICoctailsService.h"
#import "Coctail.h"

@interface CoctailInteractor ()
@property (nonatomic, strong, readonly) id<ICoctailsService> coctailsService;
@end

@implementation CoctailInteractor

#pragma mark - Initialization

- (instancetype)initWithCoctailsService:(id<ICoctailsService>)coctailsService {
    assert(nil != coctailsService);

    self = [super init];

    if (nil != self) {
        _coctailsService = coctailsService;
    }

    return self;
}

- (void)injectOutput:(id<ICoctailInteractorOutput>)output {
    assert(nil != output);

    _output = output;
}

#pragma mark - ICoctailInteractorInput

- (void)obtainDetailsForCoctail:(NSInteger)coctailIdentifier {
    assert(coctailIdentifier > -1);

    [self.coctailsService obtainDetailsForCoctail:coctailIdentifier completionHandler:[self obtainCoctailDetailsCompletion]];
}

- (void)addToFavoritedCoctail:(Coctail *)coctail {
    assert(nil != coctail);

    [self.coctailsService setFavoritedState:YES forCoctail:coctail completionHandler:[self favorCoctailCompletion]];
}

- (void)removeFromFavoritedCoctail:(Coctail *)coctail {
    assert(nil != coctail);

    [self.coctailsService setFavoritedState:NO forCoctail:coctail completionHandler:[self favorCoctailCompletion]];
}

#pragma mark - Private helpers

- (ObtainCoctailDetailsCompletion)obtainCoctailDetailsCompletion {
    __weak typeof(self) weakSelf = self;

    ObtainCoctailDetailsCompletion handler = ^(Coctail * _Nullable coctail, NSError * _Nullable error) {
        typeof(self) strongSelf = weakSelf;
        if (nil == strongSelf) {
            return;
        }

        if (nil != error) {
            [strongSelf.output didFailObtainCoctailWithError:error];
        } else if (nil != coctail) {
            [strongSelf.output didObtainCoctailWithDetails:coctail];
        } else {
            NSAssert(false, @"Unexpected behaviour in %s. 'coctail' and 'error' are nil.", __PRETTY_FUNCTION__);
        }
    };

    return [handler copy];
}

- (ChangeCoctailFavoritedStateCompletion)favorCoctailCompletion {
    __weak typeof(self) weakSelf = self;

    ChangeCoctailFavoritedStateCompletion handler = ^(Coctail *coctail, NSError * _Nullable error) {
        typeof(self) strongSelf = weakSelf;
        if (nil == strongSelf) {
            return;
        }

        if (nil != error) {
            [strongSelf.output didFailChangeFavoritedStateForCoctail:coctail error:error];
        } else if (nil != coctail) {
            [strongSelf.output didChangeFavoritedStateForCoctail:coctail];
        } else {
            NSAssert(false, @"Unexpected behaviour in %s. 'coctail' and 'error' are nil.", __PRETTY_FUNCTION__);
        }
    };

    return [handler copy];
}

@end

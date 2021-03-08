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
#import "Ingredient.h"

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

- (void)obtainRemoteCoctailsWithIngredient:(Ingredient *)ingredient {

    [self.coctailsService obtainCachedCoctailsWithPredicate:nil completionHandler:[self obtainCoctailsCompletion]];

//    [self.coctailsService obtainRemoteCoctailsWithIngredient:ingredient completionHandler:[self obtainCoctailsCompletion]];
}

#pragma mark - Private helpers

- (ObtainCoctailsCompletion)obtainCoctailsCompletion {
    __weak typeof(self) weakSelf = self;

    ObtainCoctailsCompletion handler = ^(NSArray<Coctail *> *coctails, NSError *error) {
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

@end

//
//  CoctailsService.m
//  Boozter
//
//  Created by Ivan Bukshev on 06/09/2019.
//  Copyright © 2019 Team Absurdum. All rights reserved.
//

#import "CoctailsService.h"
#import "ICoreCache.h"
#import "ICoreNetwork.h"
#import "CoctailCacheModelFiller.h"

#import "Coctail.h"
#import "Ingredient.h"
#import "ManagedCoctail.h"
#import "NSManagedObject+EntityName.h"

#import "GetCoctailsNetworkOperation.h"
#import "GetCoctailDetailsNetworkOperation.h"

@interface CoctailsService ()
@property (nonatomic, strong) id<ICoreCache> coreCache;
@property (nonatomic, strong) id<ICoreNetwork> coreNetwork;
@end

@implementation CoctailsService

#pragma mark - Initialization

- (instancetype)initWithCoreCache:(id<ICoreCache>)coreCache
                      coreNetwork:(id<ICoreNetwork>)coreNetwork {

    assert(nil != coreCache);
    assert(nil != coreNetwork);

    self = [super init];

    if (nil != self) {
        _coreCache = coreCache;
        _coreNetwork = coreNetwork;
    }

    return self;
}

#pragma mark - ICoctailsService

- (void)cacheCoctails:(NSArray<Coctail *> *)coctails {
    assert(nil != coctails);

    // TODO: Move this object to Assembly layer
    id<ICoreCacheModelFiller> modelFiller = [[CoctailCacheModelFiller alloc] init];
    [self.coreCache cacheObjects:(NSArray<IPlainObject> *)coctails withModelFiller:modelFiller];
}

- (void)obtainRemoteCoctailsWithIngredient:(Ingredient *)ingredient completionHandler:(ObtainCoctailsCompletion)completionHandler {
    assert(nil != ingredient);
    assert(NULL != completionHandler);

    void (^completion)(NSArray<Coctail *> *) = ^(NSArray<Coctail *> *coctails) {
        completionHandler(coctails, nil);
    };

    NSURL *url = [self urlForIngredient:ingredient];
    GetCoctailsNetworkOperation *operation = [[GetCoctailsNetworkOperation alloc] initWithURL:url completion:completion];
    [self.coreNetwork executeOperation:operation];
}

- (void)obtainCachedCoctailsWithPredicate:(nullable NSPredicate *)predicate completionHandler:(ObtainCoctailsCompletion)completionHandler {
    assert(NULL != completionHandler);

    NSString *entityName = [ManagedCoctail entityName];

    ObtainCachedObjectsCompletion completion = ^(NSArray<NSManagedObject *> *managedObjects, NSError *error) {
        NSArray<Coctail *> *coctails = [self plainObjectsFromManagedObjects:managedObjects];
        completionHandler(coctails, nil);
    };

    [self.coreCache obtainEntitiesWithName:entityName predicate:predicate completionHandler:[completion copy]];
}

- (void)obtainDetailsForCoctail:(NSInteger)coctailIdentifier completionHandler:(ObtainCoctailDetailsCompletion)completionHandler {
    assert(0 < coctailIdentifier);
    assert(NULL != completionHandler);

    void (^completion)(Coctail *) = ^(Coctail *coctail) {
        completionHandler(coctail, nil);
    };

    NSURL *url = [self urlForCoctailDetails:coctailIdentifier];
    GetCoctailDetailsNetworkOperation *operation = [[GetCoctailDetailsNetworkOperation alloc] initWithURL:url completion:completion];
    [self.coreNetwork executeOperation:operation];
}

- (void)setFavoritedState:(BOOL)favorited forCoctail:(Coctail *)coctail completionHandler:(ChangeCoctailFavoritedStateCompletion)completionHandler {
    assert(nil != coctail);
    assert(NULL != completionHandler);

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"identifier == %@" argumentArray:@[@(coctail.identifier)]];

    CountObjectsCompletion completion = ^(NSInteger cachedObjectsCount, NSError * _Nullable error) {
        if (cachedObjectsCount < 1) {
            [self cacheCoctails:@[coctail]];
        } else {
            NSDictionary *propertiesToUpdate = @{
                @"favorited": @YES
            };

            [self.coreCache updateEntitiesWithName:coctail.entityName
                                         predicate:predicate
                                propertiesToUpdate:propertiesToUpdate
                                 completionHandler:^(NSManagedObject * _Nullable managedCoctail, NSError * _Nullable error) {

                if (nil != error) {
                    completionHandler(coctail, error);
                } else if (nil != managedCoctail) {
                    Coctail *updatedCoctail = [[Coctail alloc] initWithManagedObject:managedCoctail];
                    completionHandler(updatedCoctail, nil);
                } else {
                    NSAssert(false, @"Unexpected behaviour in %s. 'coctail' and 'error' are nil.", __PRETTY_FUNCTION__);
                }
            }];
        }
    };

    [self.coreCache countCachedEntitiesWithName:coctail.entityName predicate:predicate completionHandler:[completion copy]];
}

#pragma mark - Private helpers

// TODO: Move this to CacheModelFiller
- (NSArray<Coctail *> *)plainObjectsFromManagedObjects:(NSArray<NSManagedObject *> *)managedObjects {
    assert(NULL != managedObjects);

    NSMutableArray<Coctail *> *plainObjects = [NSMutableArray arrayWithCapacity:managedObjects.count];

    [managedObjects enumerateObjectsUsingBlock:^(NSManagedObject *obj, NSUInteger idx, BOOL *stop) {
        ManagedCoctail *managedCoctail = (ManagedCoctail *)obj;
        Coctail *plainCoctail = [[Coctail alloc] initWithManagedObject:managedCoctail];
        [plainObjects addObject:plainCoctail];
    }];

    return [plainObjects copy];
}

// TODO: Make it more flexible...
- (NSURL *)urlForIngredient:(Ingredient *)ingredient {
    // TODO: Move it to Operation?
    NSString *formattedIngredientName = [ingredient.name stringByReplacingOccurrencesOfString:@" " withString:@"_"];
    NSString *urlString = [NSString stringWithFormat:@"https://www.thecocktaildb.com/api/json/v1/1/filter.php?i=%@", formattedIngredientName];
    NSURL *url = [NSURL URLWithString:urlString];
    return url;
}

// TODO: Make it more flexible...
- (NSURL *)urlForCoctailDetails:(NSInteger)coctailIdentifier {
    // TODO: Move it to Operation?
    NSString *urlString = [NSString stringWithFormat:@"https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=%ld", coctailIdentifier];
    NSURL *url = [NSURL URLWithString:urlString];
    return url;
}

@end

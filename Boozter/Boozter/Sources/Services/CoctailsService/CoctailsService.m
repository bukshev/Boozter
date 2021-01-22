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
//
#import "Coctail.h"
#import "ManagedCoctail.h"
#import "NSManagedObject+EntityName.h"
//
#import "GetCoctailsNetworkOperation.h"

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

- (void)obtainCoctailsFromSourcePoint:(DataSourcePoint)sourcePoint
                        withPredicate:(nullable NSPredicate *)predicate
                    completionHandler:(CoctailsServiceObtainingCompletion)completionHandler {
    assert(NULL != completionHandler);

    switch (sourcePoint) {
        case DataSourcePointCache: {
            [self obtainCachedCoctailsWithPredicate:predicate completionHandler:completionHandler];
            break;
        }
        case DataSourcePointRemote: {
            [self obtainRemoteCoctailsWithPredicate:predicate completionHandler:completionHandler];
            break;
        }
    }
}

#pragma mark - Private helpers

- (void)obtainCachedCoctailsWithPredicate:(nullable NSPredicate *)predicate
                        completionHandler:(CoctailsServiceObtainingCompletion)completionHandler {
    assert(NULL != completionHandler);

    NSString *entityName = [ManagedCoctail entityName];
    NSArray<NSManagedObject *> *managedObjects = [self.coreCache objectsForEntityName:entityName
                                                                            predicate:predicate];

    NSArray<Coctail *> *coctails = [self plainObjectsFromManagedObjects:managedObjects];
    completionHandler(coctails, nil);
}

- (void)obtainRemoteCoctailsWithPredicate:(nullable NSPredicate *)predicate
                        completionHandler:(CoctailsServiceObtainingCompletion)completionHandler {
    assert(NULL != completionHandler);

    void (^handler)(NSArray<Coctail *> *) = ^(NSArray<Coctail *> *coctails) {
        completionHandler(coctails, nil);
    };

    NSURL *url = [self urlForIngredient:@"Vodka"];
    GetCoctailsNetworkOperation *operation = [[GetCoctailsNetworkOperation alloc] initWithURL:url completion:handler];
    [self.coreNetwork executeOperation:operation];
}

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

- (NSURL *)urlForIngredient:(NSString *)ingredientName {
    NSString *urlString = [NSString stringWithFormat:@"https://www.thecocktaildb.com/api/json/v1/1/filter.php?i=%@", ingredientName];
    NSURL *url = [NSURL URLWithString:urlString];
//    if ([url checkResourceIsReachableAndReturnError:]) {
//
//    }
    return url;
}

@end

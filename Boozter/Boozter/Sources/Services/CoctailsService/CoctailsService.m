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
#import "ManagedCoctail.h"
#import "NSManagedObject+EntityName.h"

#import "GetCoctailsNetworkOperation.h"
#import "GetCoctailDetailsNetworkOperation.h"

#import <UIKit/UIApplication.h>

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

- (void)obtainRemoteCoctailsWithIngredientName:(NSString *)ingredientName
                             completionHandler:(ObtainCoctailsCompletion)completionHandler {

    assert(nil != ingredientName);
    assert(NULL != completionHandler);

    void (^handler)(NSArray<Coctail *> *) = ^(NSArray<Coctail *> *coctails) {
        completionHandler(coctails, nil);
    };

    NSURL *url = [self urlForIngredient:ingredientName];
    GetCoctailsNetworkOperation *operation = [[GetCoctailsNetworkOperation alloc] initWithURL:url completion:handler];
    [self.coreNetwork executeOperation:operation];
}

- (void)obtainDetailsForCoctail:(NSInteger)coctailIdentifier
              completionHandler:(ObtainCoctailWithDetailsCompletion)completionHandler {

    assert(0 < coctailIdentifier);
    assert(NULL != completionHandler);

    void (^handler)(Coctail *) = ^(Coctail *coctail) {
        completionHandler(coctail, nil);
    };

    NSURL *url = [self urlForCoctailDetails:coctailIdentifier];
    GetCoctailDetailsNetworkOperation *operation = [[GetCoctailDetailsNetworkOperation alloc] initWithURL:url completion:handler];
    [self.coreNetwork executeOperation:operation];
}

#pragma mark - Private helpers

- (void)obtainCachedCoctailsWithPredicate:(nullable NSPredicate *)predicate
                        completionHandler:(ObtainCoctailsCompletion)completionHandler {

    assert(NULL != completionHandler);

    NSString *entityName = [ManagedCoctail entityName];

    ObtainCachedObjectsCompletion completion = ^(NSArray<NSManagedObject *> *managedObjects, NSError *error) {
        NSArray<Coctail *> *coctails = [self plainObjectsFromManagedObjects:managedObjects];
        completionHandler(coctails, nil);
    };

    [self.coreCache obtainObjectsWithEntityName:entityName predicate:predicate completionHandler:[completion copy]];
}

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
- (NSURL *)urlForIngredient:(NSString *)ingredientName {
    // TODO: Move it to Operation?
    NSString *formattedIngredientName = [ingredientName stringByReplacingOccurrencesOfString:@" " withString:@"_"];
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

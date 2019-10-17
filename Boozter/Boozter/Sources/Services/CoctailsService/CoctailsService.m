//
//  CoctailsService.m
//  Boozter
//
//  Created by Ivan Bukshev on 06/09/2019.
//  Copyright © 2019 Team Absurdum. All rights reserved.
//

#import "CoctailsService.h"
#import "ICoreCache.h"
#import "CoctailCacheModelFiller.h"
//
#import "Coctail.h"
#import "ManagedCoctail.h"
#import "NSManagedObject+EntityName.h"

@interface CoctailsService ()
@property (nonatomic, strong) id<ICoreCache> coreCache;
@end

@implementation CoctailsService

#pragma mark - Initialization

- (instancetype)initWithCoreCache:(id<ICoreCache>)coreCache {
    assert(nil != coreCache);

    self = [super init];

    if (nil != self) {
        _coreCache = coreCache;
    }

    return self;
}

#pragma mark - ICoctailsService

- (void)cacheCoctails:(NSArray<Coctail *> *)coctails {
    assert(nil != coctails);
    id<ICoreCacheModelFiller> modelFiller = [[CoctailCacheModelFiller alloc] init];
    [self.coreCache cacheObjects:(NSArray<IPlainObject> *)coctails withModelFiller:modelFiller];
}

- (void)obtainCachedCoctailsWithPredicate:(nullable NSPredicate *)predicate
                                 callback:(CoctailsServiceObtainingCallback)callback {
    assert(NULL != callback);

    NSString *entityName = [ManagedCoctail entityName];
    NSArray<NSManagedObject *> *managedObjects = [self.coreCache objectsForEntityName:entityName
                                                                            predicate:predicate];

    NSArray<Coctail *> *coctails = [self plainObjectsFromManagedObjects:managedObjects];

    callback(coctails, nil);
}

#pragma mark - Private helpers

- (NSArray<Coctail *> *)plainObjectsFromManagedObjects:(NSArray<NSManagedObject *> *)managedObjects {
    NSMutableArray<Coctail *> *plainObjects = [NSMutableArray arrayWithCapacity:managedObjects.count];

    [managedObjects enumerateObjectsUsingBlock:^(NSManagedObject *obj, NSUInteger idx, BOOL *stop) {
        ManagedCoctail *managedCoctail = (ManagedCoctail *)obj;
        Coctail *plainCoctail = [[Coctail alloc] initWithManagedObject:managedCoctail];
        [plainObjects addObject:plainCoctail];
    }];

    return [plainObjects copy];
}

@end

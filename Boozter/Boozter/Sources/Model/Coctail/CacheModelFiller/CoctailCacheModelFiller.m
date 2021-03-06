//
//  CoctailCacher.m
//  Boozter
//
//  Created by Ivan Bukshev on 17/10/2019.
//  Copyright © 2019 Team Absurdum. All rights reserved.
//

#import "CoctailCacheModelFiller.h"
#import <CoreData/NSEntityDescription.h>
#import "ManagedCoctail.h"
#import "NSManagedObject+EntityName.h"
#import "Coctail.h"

@implementation CoctailCacheModelFiller

#pragma mark - ICoreCacheModelFiller

- (void)fillWithPlainObject:(NSObject<IPlainObject> *)object inContext:(NSManagedObjectContext *)context {
    assert(nil != object);
    assert(nil != context);
    NSAssert([object isKindOfClass:[Coctail class]], @"Plain Object is not Coctail entity.");

    Coctail *coctail = (Coctail *)object;

    NSString *entityName = [ManagedCoctail entityName];
    NSManagedObject *managedObject = [NSEntityDescription insertNewObjectForEntityForName:entityName
                                                                   inManagedObjectContext:context];

    assert([managedObject isKindOfClass:[ManagedCoctail class]]);
    ManagedCoctail *managedCoctail = (ManagedCoctail *)managedObject;

    managedCoctail.identifier = coctail.identifier;
    managedCoctail.name = [coctail.name copy];
    managedCoctail.imageURLString = [coctail.imageURL.absoluteString copy];
}

@end

//
//  CoreDataCache.m
//  Boozter
//
//  Created by Ivan Bukshev on 06/09/2019.
//  Copyright © 2019 Team Absurdum. All rights reserved.
//

#import "CoreDataCache.h"
#import <CoreData/CoreData.h>
#import "IPlainObject.h"
#import "ICoreCacheModelFiller.h"

@interface CoreDataCache ()
@property (atomic, strong) NSPersistentContainer *persistentContainer;
@end

@implementation CoreDataCache

#pragma mark - Initialization

- (instancetype)initWithIdentifier:(NSString *)identifier {
    assert(nil != identifier);

    self = [super init];
    if (nil == self) {
        return nil;
    }

    @synchronized (self) {
        if (nil != _persistentContainer) {
            return self;
        }

        _persistentContainer = [[NSPersistentContainer alloc] initWithName:[identifier copy]];
        [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *_, NSError *error) {
            if (error != nil) {
                NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                abort();
            }
        }];
    }

    return self;
}

#pragma mark - ICoreCache

- (void)saveViewContext {
    [self saveContext:self.persistentContainer.viewContext];
}

- (void)cacheObjects:(NSArray<IPlainObject> *)objects withModelFiller:(id<ICoreCacheModelFiller>)filler {
    assert(nil != objects);
    assert(nil != filler);

    __weak typeof(self) weakSelf = self;

    [weakSelf.persistentContainer performBackgroundTask:^(NSManagedObjectContext *context) {
        [objects enumerateObjectsUsingBlock:^(NSObject<IPlainObject> *object, NSUInteger idx, BOOL *stop) {
            [filler fillWithPlainObject:object inContext:context];
        }];

        [weakSelf saveContext:context];
    }];
}

- (void)obtainObjectsWithEntityName:(NSString *)entityName
                          predicate:(nullable NSPredicate *)predicate
                  completionHandler:(ObtainCachedObjectsCompletion)completionHandler {

    assert(nil != entityName);
    assert(NULL != completionHandler);

    NSManagedObjectContext *backgroundContext = [self.persistentContainer newBackgroundContext];

    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
    request.predicate = predicate;

    void (^handler)(NSAsynchronousFetchResult *) = ^(NSAsynchronousFetchResult *result) {
        if (nil != result.operationError) {
            completionHandler(nil, result.operationError);
            return;
        }

        NSArray<NSManagedObject *> *managedObjects = result.finalResult;
        if (nil == managedObjects) {
            // TODO: Generate new error for completion
            return;
        }

        completionHandler(managedObjects, nil);
    };

    NSAsynchronousFetchRequest *asyncRequest = [[NSAsynchronousFetchRequest alloc] initWithFetchRequest:request
                                                                                        completionBlock:handler];

    __autoreleasing NSError *error = nil;
    [backgroundContext executeRequest:asyncRequest error:&error];

    if (nil != error) {
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
    }
}

#pragma mark - Core Data Saving support

- (void)saveContext:(NSManagedObjectContext *)context {
    __autoreleasing NSError *error = nil;

    if ([context hasChanges] && ![context save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end

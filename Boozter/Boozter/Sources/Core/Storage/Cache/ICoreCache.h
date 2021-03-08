//
//  ICoreCache.h
//  Boozter
//
//  Created by Ivan Bukshev on 06/09/2019.
//  Copyright © 2019 Team Absurdum. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NSManagedObject;
@protocol IPlainObject;
@protocol ICoreCacheModelFiller;

typedef void (^CountObjectsCompletion)(NSInteger, NSError * _Nullable);
typedef void (^ObtainCachedObjectsCompletion)(NSArray<NSManagedObject *> * _Nullable, NSError * _Nullable);
typedef void (^UpdateObjectCompletion)(NSManagedObject * _Nullable, NSError * _Nullable);

NS_ASSUME_NONNULL_BEGIN

@protocol ICoreCache <NSObject>

- (void)saveViewContext;

- (void)countCachedEntitiesWithName:(NSString *)entityName
                          predicate:(nullable NSPredicate *)predicate
                  completionHandler:(CountObjectsCompletion)completionHandler;

- (void)cacheObjects:(NSArray<IPlainObject> *)objects
     withModelFiller:(id<ICoreCacheModelFiller>)filler;

- (void)obtainEntitiesWithName:(NSString *)entityName
                     predicate:(nullable NSPredicate *)predicate
             completionHandler:(ObtainCachedObjectsCompletion)completionHandler;

- (void)updateEntitiesWithName:(NSString *)entityName
                     predicate:(NSPredicate *)predicate
            propertiesToUpdate:(NSDictionary *)propertiesToUpdate
             completionHandler:(UpdateObjectCompletion)completionHandler;

@end

NS_ASSUME_NONNULL_END

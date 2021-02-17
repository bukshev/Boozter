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

typedef void (^ObtainCachedObjectsCompletion)(NSArray<NSManagedObject *> * _Nullable, NSError * _Nullable);

NS_ASSUME_NONNULL_BEGIN

@protocol ICoreCache <NSObject>

- (void)saveViewContext;

- (void)cacheObjects:(NSArray<IPlainObject> *)objects
     withModelFiller:(id<ICoreCacheModelFiller>)filler;

- (void)obtainObjectsWithEntityName:(NSString *)entityName
                          predicate:(nullable NSPredicate *)predicate
                  completionHandler:(ObtainCachedObjectsCompletion)completionHandler;

@end

NS_ASSUME_NONNULL_END

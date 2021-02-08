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

NS_ASSUME_NONNULL_BEGIN

@protocol ICoreCache <NSObject>

- (void)cacheObjects:(NSArray<IPlainObject> *)objects
     withModelFiller:(id<ICoreCacheModelFiller>)filler;

- (NSArray<NSManagedObject *> *)objectsForEntityName:(NSString *)entityName
                                           predicate:(nullable NSPredicate *)predicate;

@end

NS_ASSUME_NONNULL_END

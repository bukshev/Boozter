//
//  ICoreCacheModelFiller.h
//  Boozter
//
//  Created by Ivan Bukshev on 17/10/2019.
//  Copyright © 2019 Team Absurdum. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NSManagedObjectContext;
@protocol IPlainObject;

NS_ASSUME_NONNULL_BEGIN

// TODO: Add methods for converting from plain to managed and from managed to plain

@protocol ICoreCacheModelFiller <NSObject>

- (void)fillWithPlainObject:(NSObject<IPlainObject> *)object
                  inContext:(NSManagedObjectContext *)context;

@end

NS_ASSUME_NONNULL_END

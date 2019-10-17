//
//  IPlainObject.h
//  Boozter
//
//  Created by Ivan Bukshev on 17/10/2019.
//  Copyright © 2019 Team Absurdum. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NSManagedObject;

NS_ASSUME_NONNULL_BEGIN

@protocol IPlainObject <NSObject>

- (instancetype)initWithManagedObject:(NSManagedObject *)managedObject;

@end

NS_ASSUME_NONNULL_END

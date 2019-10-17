//
//  NSManagedObject+EntityName.h
//  Boozter
//
//  Created by Ivan Bukshev on 17/10/2019.
//  Copyright © 2019 Team Absurdum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/NSManagedObject.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSManagedObject (EntityName)

+ (NSString *)entityName;
- (NSString *)entityName;

@end

NS_ASSUME_NONNULL_END

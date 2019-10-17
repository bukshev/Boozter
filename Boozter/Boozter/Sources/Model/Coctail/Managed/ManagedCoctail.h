//
//  ManagedCoctail.h
//  Boozter
//
//  Created by Ivan Bukshev on 16/10/2019.
//  Copyright © 2019 Team Absurdum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/NSManagedObject.h>

NS_ASSUME_NONNULL_BEGIN

@interface ManagedCoctail : NSManagedObject

@property (nonatomic, retain) NSUUID *uuid;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *imageURLString;

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END

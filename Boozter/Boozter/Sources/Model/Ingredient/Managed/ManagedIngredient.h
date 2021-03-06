//
//  ManagedIngredient.h
//  Boozter
//
//  Created by Букшев Иван Евгеньевич on 06.03.2021.
//  Copyright © 2021 Team Absurdum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/NSManagedObject.h>

NS_ASSUME_NONNULL_BEGIN

@interface ManagedIngredient : NSManagedObject 

@property (nonatomic, retain) NSUUID *uuid;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, nullable, retain) NSString *measure;

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END

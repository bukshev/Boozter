//
//  ManagedCoctail.h
//  Boozter
//
//  Created by Ivan Bukshev on 16/10/2019.
//  Copyright © 2019 Team Absurdum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/NSManagedObject.h>
#import "ManagedIngredient.h"

NS_ASSUME_NONNULL_BEGIN

@interface ManagedCoctail : NSManagedObject

@property (nonatomic, assign) NSInteger identifier;
@property (nonatomic, assign, getter=isFavorited) BOOL favorited;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *imageURLString;
//@property (nonatomic, retain) NSString *alcoholic;
//@property (nonatomic, retain) NSString *category;
//@property (nonatomic, retain) NSString *glassName;
//@property (nonatomic, retain) NSString *instructions;
//@property (nonatomic, retain) NSArray<ManagedIngredient *> *ingredients;

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END

//
//  CoctailDetailsItem.h
//  Boozter
//
//  Created by Букшев Иван Евгеньевич on 03.02.2021.
//  Copyright © 2021 Team Absurdum. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Coctail;

NS_ASSUME_NONNULL_BEGIN

@interface CoctailDetailsItem : NSObject

@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, strong, nullable, readonly) NSData *imageData;

@property (nonatomic, copy, nullable, readonly) NSString *alcoholic;
@property (nonatomic, copy, nullable, readonly) NSString *category;
@property (nonatomic, copy, nullable, readonly) NSString *glassName;
@property (nonatomic, copy, nullable, readonly) NSString *instructions;
@property (nonatomic, copy, nullable, readonly) NSString *measuredIngredientsText;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithCoctail:(Coctail *)coctail NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END

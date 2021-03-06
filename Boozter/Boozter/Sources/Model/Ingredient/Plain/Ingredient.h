//
//  Ingredient.h
//  Boozter
//
//  Created by Букшев Иван Евгеньевич on 06.03.2021.
//  Copyright © 2021 Team Absurdum. All rights reserved.
//

#import "IPlainObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface Ingredient : NSObject <IPlainObject>

@property (nonatomic, strong, readonly) NSUUID *uuid;
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, nullable, readonly) NSString *measure;

+ (instancetype)defaultIngredient;

- (instancetype)initWithUUID:(NSUUID *)uuid
                        name:(NSString *)name
                     measure:(nullable NSString *)measure;

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END

//
//  IngredientItem.h
//  Boozter
//
//  Created by Букшев Иван Евгеньевич on 19.02.2021.
//  Copyright © 2021 Team Absurdum. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IngredientItem : NSObject

@property (nonatomic, copy, readonly) NSString *ingredientName;

- (instancetype)initWithIngredient:(NSString *)ingredientName NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END

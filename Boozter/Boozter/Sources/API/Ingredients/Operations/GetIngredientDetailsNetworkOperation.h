//
//  GetIngredientDetailsNetworkOperation.h
//  Boozter
//
//  Created by Букшев Иван Евгеньевич on 20.02.2021.
//  Copyright © 2021 Team Absurdum. All rights reserved.
//

#import "NetworkOperation.h"

NS_ASSUME_NONNULL_BEGIN

@interface GetIngredientDetailsNetworkOperation : NetworkOperation

- (instancetype)initWithIngredientName:(NSString *)ingredientName
                            completion:(void (^)(NSString *))completion NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END

//
//  GetIngredientsNetworkOperation.h
//  Boozter
//
//  Created by Букшев Иван Евгеньевич on 19.02.2021.
//  Copyright © 2021 Team Absurdum. All rights reserved.
//

#import "NetworkOperation.h"

NS_ASSUME_NONNULL_BEGIN

@interface GetIngredientsNetworkOperation : NetworkOperation

- (instancetype)initWithCompletion:(void (^)(NSArray<NSString *> *))completion NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END

//
//  GetCoctailDetailsNetworkOperation.h
//  Boozter
//
//  Created by Букшев Иван Евгеньевич on 04.02.2021.
//  Copyright © 2021 Team Absurdum. All rights reserved.
//

#import "NetworkOperation.h"

@class Coctail;

NS_ASSUME_NONNULL_BEGIN

@interface GetCoctailDetailsNetworkOperation : NetworkOperation

- (instancetype)initWithURL:(NSURL *)url
                 completion:(void (^)(Coctail *))completion NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END

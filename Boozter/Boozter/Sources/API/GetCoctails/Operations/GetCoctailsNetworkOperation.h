//
//  GetCoctailsNetworkOperation.h
//  Boozter
//
//  Created by Ivan Bukshev on 17/10/2019.
//  Copyright © 2019 Team Absurdum. All rights reserved.
//

#import "NetworkOperation.h"

@class Coctail;

NS_ASSUME_NONNULL_BEGIN

@interface GetCoctailsNetworkOperation : NetworkOperation

- (instancetype)initWithURL:(NSURL *)url
                 completion:(void (^)(NSArray<Coctail *> *))completion NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END

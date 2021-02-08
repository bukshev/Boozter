//
//  CoreNetwork.h
//  Boozter
//
//  Created by Ivan Bukshev on 17/10/2019.
//  Copyright © 2019 Team Absurdum. All rights reserved.
//

#import "ICoreNetwork.h"

@class NetworkOperationQueue;

NS_ASSUME_NONNULL_BEGIN

@interface CoreNetwork : NSObject<ICoreNetwork>

- (instancetype)initWithQueue:(NetworkOperationQueue *)queue NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END

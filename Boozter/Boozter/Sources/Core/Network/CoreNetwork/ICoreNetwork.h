//
//  ICoreNetwork.h
//  Boozter
//
//  Created by Ivan Bukshev on 17/10/2019.
//  Copyright © 2019 Team Absurdum. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NetworkOperation;

NS_ASSUME_NONNULL_BEGIN

@protocol ICoreNetwork <NSObject>

@required
- (void)executeOperation:(NetworkOperation *)operation;

@end

NS_ASSUME_NONNULL_END

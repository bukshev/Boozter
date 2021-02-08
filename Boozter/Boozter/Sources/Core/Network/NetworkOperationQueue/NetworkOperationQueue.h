//
//  NetworkOperationQueue.h
//  Boozter
//
//  Created by Ivan Bukshev on 17/10/2019.
//  Copyright © 2019 Team Absurdum. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NetworkOperation;

NS_ASSUME_NONNULL_BEGIN

@interface NetworkOperationQueue : NSObject

+ (instancetype)sharedInstance;

- (void)addOperation:(NetworkOperation *)operation;

@end

NS_ASSUME_NONNULL_END

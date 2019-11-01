//
//  NetworkOperation.h
//  Boozter
//
//  Created by Ivan Bukshev on 17/10/2019.
//  Copyright © 2019 Team Absurdum. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NetworkOperation : NSOperation

/// Finishes the execution of the operation.
/// @note This shouldn’t be called externally as this is used internally by subclasses.
/// To cancel an operation use cancel instead.
- (void)finish;

@end

NS_ASSUME_NONNULL_END

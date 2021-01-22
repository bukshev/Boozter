//
//  NetworkOperation.h
//  Boozter
//
//  Created by Ivan Bukshev on 17/10/2019.
//  Copyright © 2019 Team Absurdum. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IErrorProcessor;

NS_ASSUME_NONNULL_BEGIN

@interface NetworkOperation : NSOperation

@property (nonatomic, copy, readonly) NSURL *url;
@property (nonatomic, strong, readonly) id<IErrorProcessor> errorProcessor;

- (instancetype)initWithURL:(NSURL *)url errorProcessor:(id<IErrorProcessor>)errorProcessor;

/// Starts the execution of the operation.
/// @note Shouldn’t be called externally as this is used internally by subclasses.
- (void)start;

/// Finishes the execution of the operation.
/// @note Shouldn’t be called externally as this is used internally by subclasses.
- (void)finish;

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END

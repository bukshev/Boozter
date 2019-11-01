//
//  IErrorProcessor.h
//  Boozter
//
//  Created by Ivan Bukshev on 18/10/2019.
//  Copyright © 2019 Team Absurdum. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol IErrorProcessor <NSObject>

- (void)processError:(NSError *)error;

@end

NS_ASSUME_NONNULL_END

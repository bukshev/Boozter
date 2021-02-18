//
//  IProgressIndication.h
//  Boozter
//
//  Created by Ivan Bukshev on 23/10/2019.
//  Copyright © 2019 Team Absurdum. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol IProgressIndication <NSObject>

- (void)showProgressHUD:(nullable NSString *)statusMessage;
- (void)hideProgressHUD;

@end

NS_ASSUME_NONNULL_END

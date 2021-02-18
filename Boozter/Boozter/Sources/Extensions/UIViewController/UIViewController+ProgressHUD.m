//
//  UIViewController+ProgressHUD.m
//  Boozter
//
//  Created by Ivan Bukshev on 23/10/2019.
//  Copyright © 2019 Team Absurdum. All rights reserved.
//

#import "UIViewController+ProgressHUD.h"
#import <SVProgressHUD/SVProgressHUD.h>

@implementation UIViewController (ProgressHUD)

- (void)showProgressHUD:(nullable NSString *)statusMessage {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (nil != statusMessage) {
            [SVProgressHUD showWithStatus:statusMessage];
        } else {
            [SVProgressHUD show];
        }
    });
}

- (void)hideProgressHUD {
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

@end

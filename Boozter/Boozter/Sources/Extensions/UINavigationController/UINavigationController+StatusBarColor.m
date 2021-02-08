//
//  UINavigationController+StatusBarColor.m
//  Boozter
//
//  Created by Букшев Иван Евгеньевич on 05.02.2021.
//  Copyright © 2021 Team Absurdum. All rights reserved.
//

#import "UINavigationController+StatusBarColor.h"

@implementation UINavigationController (StatusBarColor)

- (void)setStatusBarColor:(UIColor *)color {
    assert(nil != color);

    CGRect statusBarFrame;
    if (@available(iOS 13, *)) {
        statusBarFrame = self.view.window.windowScene.statusBarManager.statusBarFrame;
    } else {
        statusBarFrame = UIApplication.sharedApplication.statusBarFrame;
    }

    UIView *statusBarView = [[UIView alloc] initWithFrame:statusBarFrame];
    statusBarView.backgroundColor = color;

    [self.view addSubview:statusBarView];
}

@end

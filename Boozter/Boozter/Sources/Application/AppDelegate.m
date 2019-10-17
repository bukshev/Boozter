//
//  AppDelegate.m
//  Boozter
//
//  Created by Ivan Bukshev on 02/09/2019.
//  Copyright © 2019 Team Absurdum. All rights reserved.
//

#import "AppDelegate.h"
#import <Typhoon/Typhoon.h>

#import "HomeDashboardModuleAssembly.h"
#import "CoctailModuleAssembly.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    return YES;
}

- (NSArray *)initialAssemblies {
    return @[
        [HomeDashboardModuleAssembly class],
        [CoctailModuleAssembly class]
    ];
}

@end

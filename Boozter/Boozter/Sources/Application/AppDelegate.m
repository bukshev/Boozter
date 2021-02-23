//
//  AppDelegate.m
//  Boozter
//
//  Created by Ivan Bukshev on 02/09/2019.
//  Copyright © 2019 Team Absurdum. All rights reserved.
//

#import "AppDelegate.h"
#import <Typhoon/Typhoon.h>

#import "UtilitiesAssembly.h"
#import "CoreAssembly.h"
#import "ServicesAssembly.h"

#import "HomeDashboardModuleAssembly.h"
#import "CoctailModuleAssembly.h"
#import "IngredientsModuleAssembly.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    return YES;
}

- (NSArray *)initialAssemblies {
    return @[
        [UtilitiesAssembly class],
        [CoreAssembly class],
        [ServicesAssembly class],
        [HomeDashboardModuleAssembly class],
        [CoctailModuleAssembly class],
        [IngredientsModuleAssembly class]
    ];
}

@end

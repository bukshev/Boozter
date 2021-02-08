//
//  HomeDashboardViewController.h
//  Boozter
//
//  Created by Ivan Bukshev on 02/09/2019.
//  Copyright © 2019 Team Absurdum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IHomeDashboardViewInput.h"

@protocol IHomeDashboardViewOutput;

@class HomeDashboardDataSource;

NS_ASSUME_NONNULL_BEGIN

@interface HomeDashboardViewController : UIViewController <IHomeDashboardViewInput>

@property (nonatomic, strong, readonly) id<IHomeDashboardViewOutput> output;

- (void)injectOutput:(id<IHomeDashboardViewOutput>)output;
- (void)injectDataSource:(HomeDashboardDataSource *)dataSource;

@end

NS_ASSUME_NONNULL_END

//
//  CoctailViewController.h
//  Boozter
//
//  Created by Ivan Bukshev on 05/09/2019.
//  Copyright © 2019 Team Absurdum. All rights reserved.
//

#import <UIKit/UIViewController.h>
#import "ICoctailViewInput.h"

@protocol ICoctailViewOutput;

NS_ASSUME_NONNULL_BEGIN

@interface CoctailViewController : UIViewController<ICoctailViewInput>

@property (nonatomic, strong, readonly) id<ICoctailViewOutput> output;

- (void)injectOutput:(id<ICoctailViewOutput>)output;

@end

NS_ASSUME_NONNULL_END

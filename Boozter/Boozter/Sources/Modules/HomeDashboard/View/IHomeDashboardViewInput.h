//
//  IHomeDashboardViewInput.h
//  Boozter
//
//  Created by Ivan Bukshev on 02/09/2019.
//  Copyright © 2019 Team Absurdum. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NSIndexPath;

NS_ASSUME_NONNULL_BEGIN

@protocol IHomeDashboardViewInput <NSObject>

- (void)setupInitialState;

- (void)reloadData;
- (void)reloadItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths;

@end

NS_ASSUME_NONNULL_END
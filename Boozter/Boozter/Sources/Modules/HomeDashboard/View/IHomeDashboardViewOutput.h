//
//  IHomeDashboardViewOutput.h
//  Boozter
//
//  Created by Ivan Bukshev on 02/09/2019.
//  Copyright © 2019 Team Absurdum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CGGeometry.h>

NS_ASSUME_NONNULL_BEGIN

@protocol IHomeDashboardViewOutput <NSObject>

- (void)onViewReadyEvent:(CGSize)screenSize;
- (void)onSearchIngredientInputEvent:(NSString *)ingredientName;

- (void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
- (CGSize)sizeForItemAtIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END

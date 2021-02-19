//
//  IIngredientsViewOutput.h
//  Boozter
//
//  Created by Букшев Иван Евгеньевич on 19.02.2021.
//  Copyright © 2021 Team Absurdum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CGGeometry.h>

NS_ASSUME_NONNULL_BEGIN

@protocol IIngredientsViewOutput <NSObject>

- (void)onViewReadyEvent:(CGSize)screenSize;
- (void)onSelectFilter;

- (void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
- (CGSize)sizeForItemAtIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END

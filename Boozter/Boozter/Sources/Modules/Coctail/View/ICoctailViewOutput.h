//
//  ICoctailViewOutput.h
//  Boozter
//
//  Created by Букшев Иван Евгеньевич on 03.02.2021.
//  Copyright © 2021 Team Absurdum. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ICoctailViewOutput <NSObject>

- (void)onViewReadyEvent;
- (void)onFavorEvent;

@end

NS_ASSUME_NONNULL_END

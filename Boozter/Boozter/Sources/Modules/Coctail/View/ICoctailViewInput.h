//
//  ICoctailViewInput.h
//  Boozter
//
//  Created by Букшев Иван Евгеньевич on 03.02.2021.
//  Copyright © 2021 Team Absurdum. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CoctailDetailsItem;

NS_ASSUME_NONNULL_BEGIN

@protocol ICoctailViewInput <NSObject>

- (void)setupInitialStateWithTitle:(NSString *)title;
- (void)configureWithItem:(CoctailDetailsItem *)item;
- (void)updateImageWithData:(NSData *)imageData;

- (void)setFavoritedState;
- (void)discardFavoritedState;

@end

NS_ASSUME_NONNULL_END

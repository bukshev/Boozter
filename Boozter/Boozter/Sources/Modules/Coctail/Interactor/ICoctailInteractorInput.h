//
//  ICoctailInteractorInput.h
//  Boozter
//
//  Created by Букшев Иван Евгеньевич on 03.02.2021.
//  Copyright © 2021 Team Absurdum. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Coctail;

NS_ASSUME_NONNULL_BEGIN

@protocol ICoctailInteractorInput <NSObject>

@required
- (void)obtainDetailsForCoctail:(NSInteger)coctailIdentifier;
- (void)addToFavoritedCoctail:(Coctail *)coctail;
- (void)removeFromFavoritedCoctail:(Coctail *)coctail;

@end

NS_ASSUME_NONNULL_END

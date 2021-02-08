//
//  ICoctailInteractorOutput.h
//  Boozter
//
//  Created by Букшев Иван Евгеньевич on 03.02.2021.
//  Copyright © 2021 Team Absurdum. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Coctail;

NS_ASSUME_NONNULL_BEGIN

@protocol ICoctailInteractorOutput <NSObject>

@required
- (void)didObtainCoctailWithDetails:(Coctail *)coctail;
- (void)didFailObtainCoctailWithError:(NSError *)error;

@end

NS_ASSUME_NONNULL_END

//
//  IHomeDashboardInteractorOutput.h
//  Boozter
//
//  Created by Ivan Bukshev on 02/09/2019.
//  Copyright © 2019 Team Absurdum. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Coctail;

NS_ASSUME_NONNULL_BEGIN

@protocol IHomeDashboardInteractorOutput <NSObject>

@required
- (void)didObtainCoctails:(NSArray<Coctail *> *)coctails;
- (void)didFailObtainCoctailsWithError:(NSError *)error;

@end

NS_ASSUME_NONNULL_END

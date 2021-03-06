//
//  IHomeDashboardRouterInput.h
//  Boozter
//
//  Created by Ivan Bukshev on 02/09/2019.
//  Copyright © 2019 Team Absurdum. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IIngredientsModuleOutput;

@class Coctail;

NS_ASSUME_NONNULL_BEGIN

@protocol IHomeDashboardRouterInput <NSObject>

- (void)openDetailScreenWithCoctail:(Coctail *)coctail;
- (void)openIngredientsScreenWithModuleOutput:(id<IIngredientsModuleOutput>)moduleOutput;

@end

NS_ASSUME_NONNULL_END

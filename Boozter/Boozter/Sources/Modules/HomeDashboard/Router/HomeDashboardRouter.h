//
//  HomeDashboardRouter.h
//  Boozter
//
//  Created by Ivan Bukshev on 02/09/2019.
//  Copyright © 2019 Team Absurdum. All rights reserved.
//

#import "IHomeDashboardRouterInput.h"

@protocol IModuleTransitionHandler;
@protocol IModuleFactory;

NS_ASSUME_NONNULL_BEGIN

@interface HomeDashboardRouter : NSObject <IHomeDashboardRouterInput>

@property (nonatomic, weak, nullable, readonly) id<IModuleTransitionHandler> transitionHandler;

-  (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithCoctailModuleFactory:(id<IModuleFactory>)coctailModuleFactory
                    ingredientsModuleFactory:(id<IModuleFactory>)ingredientsModuleFactory NS_DESIGNATED_INITIALIZER;

- (void)injectTransitionHandler:(id<IModuleTransitionHandler>)transitionHandler;

@end

NS_ASSUME_NONNULL_END

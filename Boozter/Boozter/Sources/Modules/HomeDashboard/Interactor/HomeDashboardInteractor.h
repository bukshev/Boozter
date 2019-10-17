//
//  HomeDashboardInteractor.h
//  Boozter
//
//  Created by Ivan Bukshev on 02/09/2019.
//  Copyright © 2019 Team Absurdum. All rights reserved.
//

#import "IHomeDashboardInteractorInput.h"

@protocol IHomeDashboardInteractorOutput;
@protocol ICoctailsService;

NS_ASSUME_NONNULL_BEGIN

@interface HomeDashboardInteractor : NSObject <IHomeDashboardInteractorInput>

@property (nonatomic, weak, readonly) id<IHomeDashboardInteractorOutput> output;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithCoctailsService:(id<ICoctailsService>)coctailsService NS_DESIGNATED_INITIALIZER;

- (void)injectOutput:(id<IHomeDashboardInteractorOutput>)output;

@end

NS_ASSUME_NONNULL_END

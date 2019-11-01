//
//  HomeDashboardPresenter.h
//  Boozter
//
//  Created by Ivan Bukshev on 02/09/2019.
//  Copyright © 2019 Team Absurdum. All rights reserved.
//

#import "IHomeDashboardViewOutput.h"
#import "IHomeDashboardInteractorOutput.h"

@protocol IHomeDashboardViewInput;
@protocol IProgressIndication;
@protocol IHomeDashboardInteractorInput;
@protocol IHomeDashboardRouterInput;

@class HomeDashboardDataSource;

NS_ASSUME_NONNULL_BEGIN

@interface HomeDashboardPresenter : NSObject <IHomeDashboardViewOutput, IHomeDashboardInteractorOutput>

@property (nonatomic, weak, nullable, readonly) id<IHomeDashboardViewInput, IProgressIndication> view;
@property (nonatomic, strong, readonly) id<IHomeDashboardInteractorInput> interactor;
@property (nonatomic, strong, readonly) id<IHomeDashboardRouterInput> router;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithInteractor:(id<IHomeDashboardInteractorInput>)interactor
                            router:(id<IHomeDashboardRouterInput>)router NS_DESIGNATED_INITIALIZER;

- (void)injectView:(id<IHomeDashboardViewInput, IProgressIndication>)view;
- (void)injectDataSource:(HomeDashboardDataSource *)dataSource;

@end

NS_ASSUME_NONNULL_END

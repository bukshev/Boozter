//
//  CoctailInteractor.h
//  Boozter
//
//  Created by Букшев Иван Евгеньевич on 03.02.2021.
//  Copyright © 2021 Team Absurdum. All rights reserved.
//

#import "ICoctailInteractorInput.h"

@protocol ICoctailInteractorOutput;
@protocol ICoctailsService;

NS_ASSUME_NONNULL_BEGIN

@interface CoctailInteractor : NSObject<ICoctailInteractorInput>

@property (nonatomic, weak, readonly) id<ICoctailInteractorOutput> output;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithCoctailsService:(id<ICoctailsService>)coctailsService NS_DESIGNATED_INITIALIZER;

- (void)injectOutput:(id<ICoctailInteractorOutput>)output;

@end

NS_ASSUME_NONNULL_END

//
//  IngredientsInteractor.h
//  Boozter
//
//  Created by Букшев Иван Евгеньевич on 19.02.2021.
//  Copyright © 2021 Team Absurdum. All rights reserved.
//

#import "IIngredientsInteractorInput.h"

@protocol IIngredientsInteractorOutput;
@protocol IIngredientsService;

NS_ASSUME_NONNULL_BEGIN

@interface IngredientsInteractor : NSObject <IIngredientsInteractorInput>

@property (nonatomic, weak, readonly) id<IIngredientsInteractorOutput> output;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithIngredientsService:(id<IIngredientsService>)ingredientsService NS_DESIGNATED_INITIALIZER;

- (void)injectOutput:(id<IIngredientsInteractorOutput>)output;

@end

NS_ASSUME_NONNULL_END

//
//  IngredientsPresenter.h
//  Boozter
//
//  Created by Букшев Иван Евгеньевич on 19.02.2021.
//  Copyright © 2021 Team Absurdum. All rights reserved.
//

#import "IIngredientsViewOutput.h"
#import "IIngredientsInteractorOutput.h"
#import "IIngredientsModuleInput.h"

@protocol IIngredientsViewInput;
@protocol IIngredientsInteractorInput;
@protocol IProgressIndication;
@protocol IImageDownloader;

@class IngredientsDataSource;

NS_ASSUME_NONNULL_BEGIN

@interface IngredientsPresenter : NSObject <IIngredientsModuleInput,IIngredientsViewOutput, IIngredientsInteractorOutput>

@property (nonatomic, weak, nullable, readonly) id<IIngredientsViewInput, IProgressIndication> view;
@property (nonatomic, strong, readonly) id<IIngredientsInteractorInput> interactor;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithInteractor:(id<IIngredientsInteractorInput>)interactor
                   imageDownloader:(id<IImageDownloader>)imageDownloader NS_DESIGNATED_INITIALIZER;

- (void)injectView:(id<IIngredientsViewInput, IProgressIndication>)view;
- (void)injectDataSource:(IngredientsDataSource *)dataSource;

@end

NS_ASSUME_NONNULL_END

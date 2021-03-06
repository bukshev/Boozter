//
//  CoctailPresenter.h
//  Boozter
//
//  Created by Букшев Иван Евгеньевич on 03.02.2021.
//  Copyright © 2021 Team Absurdum. All rights reserved.
//

#import "ICoctailModuleInput.h"
#import "ICoctailViewOutput.h"
#import "ICoctailInteractorOutput.h"

@protocol ICoctailViewInput;
@protocol ICoctailInteractorInput;
@protocol IImageDownloader;

NS_ASSUME_NONNULL_BEGIN

@interface CoctailPresenter : NSObject <ICoctailModuleInput, ICoctailViewOutput, ICoctailInteractorOutput>

@property (nonatomic, weak, nullable, readonly) id<ICoctailViewInput> view;
@property (nonatomic, strong, nullable, readonly) id<ICoctailInteractorInput> interactor;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithInteractor:(id<ICoctailInteractorInput>)interactor
                   imageDownloader:(id<IImageDownloader>)imageDownloader NS_DESIGNATED_INITIALIZER;

- (void)injectView:(id<ICoctailViewInput>)view;

@end

NS_ASSUME_NONNULL_END

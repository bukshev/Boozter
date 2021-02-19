//
//  IngredientsPresenter.m
//  Boozter
//
//  Created by Букшев Иван Евгеньевич on 19.02.2021.
//  Copyright © 2021 Team Absurdum. All rights reserved.
//

#import "IngredientsPresenter.h"
#import "IngredientsFilter.h"
#import "IIngredientsModuleOutput.h"
#import "IIngredientsViewInput.h"
#import "IIngredientsInteractorInput.h"
#import "IProgressIndication.h"
#import "IImageDownloader.h"
#import "IngredientsDataSource.h"

static CGFloat const kSecondsDelayBeforeShowingView = 0.55f;

@interface IngredientsPresenter ()
@property (nonatomic, strong) id<IImageDownloader> imageDownloader;
@property (nonatomic, weak) IngredientsDataSource *dataSource;
@property (nonatomic, weak) id<IIngredientsModuleOutput> moduleOutput;
@property (nonatomic, assign) CGFloat ingredientCellHeight;
@end

@implementation IngredientsPresenter

#pragma mark - Initialization

- (instancetype)initWithInteractor:(id<IIngredientsInteractorInput>)interactor
                   imageDownloader:(id<IImageDownloader>)imageDownloader {

    assert(nil != interactor);
    assert(nil != imageDownloader);

    self = [super init];

    if (nil != self) {
        _interactor = interactor;
        _imageDownloader = imageDownloader;
    }

    return self;
}

- (void)injectView:(id<IIngredientsViewInput,IProgressIndication>)view {
    assert(nil != view);
    
    _view = view;
}

- (void)injectDataSource:(IngredientsDataSource *)dataSource {
    assert(nil != dataSource);

    _dataSource = dataSource;
}

#pragma mark - IIngredientsModuleInput

- (void)setModuleOutput:(id<IIngredientsModuleOutput>)moduleOutput {
    assert(nil != moduleOutput);

    _moduleOutput = moduleOutput;
}

#pragma mark - IIngredientsViewOutput

- (void)onViewReadyEvent:(CGSize)screenSize {
    _ingredientCellHeight = [self ingredientCellHeightForScreenSize:screenSize];

    [self.view setupInitialState];

    [self.view showBlurEffect];
    [self.view showProgressHUD:@"Подгружаем данные"];

    [self.interactor obtainAvailableIngredients];
}

- (void)onViewDismissEvent {
    NSSet *ingredientsSet = [NSSet setWithArray:[self.dataSource selectedIngredients]];
    IngredientsFilter *filter = [[IngredientsFilter alloc] initWithIngredientsSet:ingredientsSet];
    [self.moduleOutput didSetFilter:filter];
}

- (void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.dataSource triggerSelectedStatusForIndexPath:indexPath];
}

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.ingredientCellHeight;
}

#pragma mark - IIngredientsInteractorOutput

- (void)didObtainIngredients:(NSArray<NSString *> *)ingredients {
    assert(nil != ingredients);

    [self.dataSource updateWithIngredients:ingredients];

    dispatch_async(dispatch_get_main_queue(), ^{
        [self.view reloadData];
        [self hideBlurViewAfterLoading];
    });
}

- (void)didFailObtainIngredientsWithError:(NSError *)error {
    assert(nil != error);
}

#pragma mark - Private helpers

- (void)hideBlurViewAfterLoading {
    dispatch_time_t deadline = dispatch_time(DISPATCH_TIME_NOW, kSecondsDelayBeforeShowingView * NSEC_PER_SEC);
    dispatch_after(deadline, dispatch_get_main_queue(), ^{
        [self.view hideProgressHUD];
        [self.view hideBlurEffect];
    });
}

- (CGFloat)ingredientCellHeightForScreenSize:(CGSize)screenSize {
    assert(CGSizeZero.width != screenSize.width);

    CGFloat cellHeight = screenSize.width / 5.0f;

    return cellHeight;
}

@end

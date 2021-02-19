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

static CGFloat const kSecondsDelayBeforeShowingView = 0.75f;

@interface IngredientsPresenter ()
@property (nonatomic, strong) id<IImageDownloader> imageDownloader;
@property (nonatomic, strong, nullable) IngredientsFilter *filter;
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

- (void)setIngredientsFilter:(IngredientsFilter *)filter {
    assert(nil != filter);

    _filter = filter;
}

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

- (void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

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
    assert(CGSizeZero.height != screenSize.height);
    assert(CGSizeZero.width != screenSize.width);

//    CGFloat const indent = 16;
//    CGFloat const width = (screenSize.width / 2.0f) - (indent * 2.0f);
//    CGFloat const height = width * 1.2f;

    return 44.0f;
}

@end

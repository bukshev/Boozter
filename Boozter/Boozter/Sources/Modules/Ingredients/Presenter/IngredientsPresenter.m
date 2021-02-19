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

@interface IngredientsPresenter ()
@property (nonatomic, strong) id<IImageDownloader> imageDownloader;
@property (nonatomic, strong, nullable) IngredientsFilter *filter;
@property (nonatomic, weak) IngredientsDataSource *dataSource;
@property (nonatomic, weak) id<IIngredientsModuleOutput> moduleOutput;
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

@end

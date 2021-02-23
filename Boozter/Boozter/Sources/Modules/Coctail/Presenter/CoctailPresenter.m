//
//  CoctailPresenter.m
//  Boozter
//
//  Created by Букшев Иван Евгеньевич on 03.02.2021.
//  Copyright © 2021 Team Absurdum. All rights reserved.
//

#import "CoctailPresenter.h"
#import "ICoctailViewInput.h"
#import "ICoctailInteractorInput.h"
#import "IImageDownloader.h"
#import "IProgressIndication.h"
#import "Coctail.h"
#import "CoctailDetailsItem.h"


@interface CoctailPresenter ()
@property (nonatomic, strong) id<IImageDownloader> imageDownloader;
@property (nonatomic, strong) Coctail *coctail;
@end

@implementation CoctailPresenter

#pragma mark - Initialization

- (instancetype)initWithInteractor:(id<ICoctailInteractorInput>)interactor
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

- (void)injectView:(id<ICoctailViewInput,IProgressIndication>)view {
    assert(nil != view);
    _view = view;
}

#pragma mark - ICoctailModuleInput

- (void)setCoctail:(Coctail *)coctail {
    assert(nil != coctail);
    _coctail = coctail;
}

#pragma mark - ICoctailViewOutput

- (void)onViewReadyEvent {
    assert(nil != self.coctail.imageURL);

    [self.view setupInitialState];
    [self.view configureWithItem:[self itemForCoctail:self.coctail]];
    [self.view showProgressHUD:@"Подгружаем данные"];

    [self.imageDownloader downloadImageFromURL:self.coctail.imageURL
                             completionHandler:[self imageDownloadCompletion]];

    if (!self.coctail.hasDetails) {
        [self.interactor obtainDetailsForCoctail:self.coctail.identifier];
    }
}

#pragma mark - ICoctailInteractorOutput

- (void)didObtainCoctailWithDetails:(Coctail *)coctail {
    assert(nil != coctail);

    self.coctail = coctail;

    dispatch_async(dispatch_get_main_queue(), ^{
        [self.view configureWithItem:[self itemForCoctail:self.coctail]];
        [self.view hideProgressHUD];
    });
}

- (void)didFailObtainCoctailWithError:(NSError *)error {
    assert(nil != error);

    dispatch_async(dispatch_get_main_queue(), ^{
        [self.view hideProgressHUD];
    });
}

#pragma mark - Private helpers

- (CoctailDetailsItem *)itemForCoctail:(Coctail *)coctail {
    assert(nil != coctail);
    return [[CoctailDetailsItem alloc] initWithCoctail:coctail];
}

- (ImageDownloadCompletion)imageDownloadCompletion {
    __weak typeof(self) weakSelf = self;

    ImageDownloadCompletion handler = ^(NSData *data, NSURL *url, NSError *error) {
        typeof(self) strongSelf = weakSelf;
        if (nil == strongSelf) {
            return;
        }

        if (nil != error) {
            [strongSelf didFailDownloadImageDataWithError:error];
        } else {
            [strongSelf didDownloadImageData:data];
        }
    };

    return [handler copy];
}

- (void)didDownloadImageData:(NSData *)imageData {
    assert(nil != imageData);

    [self.coctail updateImageData:imageData];

    dispatch_async(dispatch_get_main_queue(), ^{
        [self.view updateImageWithData:imageData];
        [self.view hideProgressHUD];
    });
}

- (void)didFailDownloadImageDataWithError:(NSError *)error {
    assert(nil != error);

    dispatch_async(dispatch_get_main_queue(), ^{
        [self.view hideProgressHUD];
    });

    // TODO: Set placeholder image.
}

@end

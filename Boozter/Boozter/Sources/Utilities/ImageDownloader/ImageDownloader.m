//
//  ImageDownloader.m
//  Boozter
//
//  Created by Ivan Bukshev on 23/10/2019.
//  Copyright © 2019 Team Absurdum. All rights reserved.
//

#import "ImageDownloader.h"
#import "ImageDownloadOperation.h"

@interface ImageDownloader ()
@property (nonatomic, strong) NSOperationQueue *downloadQueue;
@property (nonatomic, strong) NSCache<NSString *, NSData *> *cache;
@property (nonatomic, copy) ImageForIndexPathDownloadCompletion completionHandler;
@end

@implementation ImageDownloader

#pragma mark - Initialization

+ (instancetype)sharedInstance {
    static ImageDownloader *shared = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[self alloc] init];
    });

    return shared;
}

- (instancetype)init {
    self = [super init];

    if (nil != self) {
        _cache = [[NSCache<NSString *, NSData *> alloc] init];
    }

    return self;
}

#pragma mark - IImageDownloader

- (void)downloadImageFromURL:(NSURL *)url
           completionHandler:(ImageDownloadCompletion)completionHandler {

    assert(nil != url);
    assert(NULL != completionHandler);

    // Just ignoring indexPath in full-format completionHadler.
    [self downloadImageFromURL:url indexPath:nil completionHandler:^(NSData *data, NSURL *url, NSIndexPath *indexPath, NSError *error) {
        completionHandler(data, url, error);
    }];
}

- (void)downloadImageFromURL:(NSURL *)url
                   indexPath:(nullable NSIndexPath *)indexPath
           completionHandler:(ImageForIndexPathDownloadCompletion)completionHandler {

    assert(nil != url);
    assert(NULL != completionHandler);

    NSData *cachedImageData = [self.cache objectForKey:url.absoluteString];
    if (nil != cachedImageData) {
        completionHandler(cachedImageData, url, indexPath, nil);
        return;
    }

    __block BOOL isDownloadingOperationExists = NO;
    NSArray<ImageDownloadOperation *> *operations = (NSArray<ImageDownloadOperation *> *)self.downloadQueue.operations;
    [operations enumerateObjectsUsingBlock:^(ImageDownloadOperation *operation, NSUInteger index, BOOL *stop) {
        if ([operation.url.absoluteString isEqualToString:url.absoluteString] && (NO == operation.isFinished) && operation.isExecuting) {
            isDownloadingOperationExists = YES;
            operation.queuePriority = NSURLSessionTaskPriorityHigh;
            *stop = YES;
        }
    }];

    if (isDownloadingOperationExists) {
        // Downloading operation already exists, priority was updgraded, so just leave function.
        return;
    }

    ImageForIndexPathDownloadCompletion downloadHandler = ^(NSData *imageData, NSURL *url, NSIndexPath *indexPath, NSError *error) {
        if (nil != imageData) {
            [self.cache setObject:imageData forKey:url.absoluteString];
        }
        completionHandler(imageData, url, indexPath, error);
    };

    ImageDownloadOperation *newOperation = [[ImageDownloadOperation alloc] initWithURL:url
                                                                             indexPath:indexPath
                                                                     completionHandler:downloadHandler];

    if (nil == indexPath) {
        newOperation.queuePriority = NSOperationQueuePriorityVeryHigh;
    }

    [self.downloadQueue addOperation:newOperation];
}

- (void)slowDownImageDownloadingFromURL:(NSURL *)url {
    assert(nil != url);

    [self.downloadQueue.operations enumerateObjectsUsingBlock:^(ImageDownloadOperation *operation, NSUInteger idx, BOOL *stop) {
        if ([operation.url.absoluteString isEqualToString:url.absoluteString] && (NO == operation.isFinished) && operation.isExecuting) {
            operation.queuePriority = NSOperationQueuePriorityVeryLow;
            *stop = YES;
        }
    }];
}

- (void)cancelAllOperations {
    [self.downloadQueue cancelAllOperations];
}

- (void)invalidateCache {
    [self.cache removeAllObjects];
}

#pragma mark - Getters & Setters

- (NSOperationQueue *)downloadQueue {
    if (nil != _downloadQueue) {
        return _downloadQueue;
    }

    _downloadQueue = [[NSOperationQueue alloc] init];
    _downloadQueue.name = [[NSBundle mainBundle].bundlePath stringByAppendingString:@".ImageDownloadQueue"];
    _downloadQueue.qualityOfService = NSQualityOfServiceUserInteractive;

    return _downloadQueue;
}

@end

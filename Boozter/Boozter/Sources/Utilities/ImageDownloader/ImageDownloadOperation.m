//
//  ImageDownloadOperation.m
//  Boozter
//
//  Created by Ivan Bukshev on 23/10/2019.
//  Copyright © 2019 Team Absurdum. All rights reserved.
//

#import "ImageDownloadOperation.h"

@interface ImageDownloadOperation ()
@property (nonatomic, strong, readwrite) NSIndexPath *indexPath;
@property (nonatomic, copy, readwrite) ImageForIndexPathDownloadCompletion completionHandler;
@end

@implementation ImageDownloadOperation

#pragma mark - Initialization

- (instancetype)initWithURL:(NSURL *)url
                  indexPath:(NSIndexPath *)indexPath
          completionHandler:(ImageForIndexPathDownloadCompletion)completionHandler {
    assert(nil != url);
    assert(NULL != completionHandler);

    self = [super initWithURL:url];

    if (nil != self) {
        _indexPath = indexPath;
        _completionHandler = completionHandler;
    }

    return self;
}

#pragma mark - NSOperation

- (void)start {
    [super start];

    NSURLSession *session = [NSURLSession sharedSession];

    void (^completionHandler)(NSURL *, NSURLResponse *, NSError *) = ^(NSURL *location, NSURLResponse *response, NSError *error) {
        if (nil != error || nil == location) {
            return;
        }

        NSData *imageData = [NSData dataWithContentsOfURL:location];
        if (nil == imageData) {
            return;
        }

        if (NULL != self.completionHandler) {
            self.completionHandler(imageData, self.url, self.indexPath, error);
        } else {
            NSString *message = @"completionHandler was not set.";
            NSAssert(NO, message);
            NSLog(@"%s: %@", __PRETTY_FUNCTION__, message);
            return;
        }

        [self finish];
    };

    NSURLSessionDownloadTask *task = [session downloadTaskWithURL:self.url completionHandler:completionHandler];
    [task resume];
}

- (void)cancel {
    [super cancel];
    [self finish];
}

@end

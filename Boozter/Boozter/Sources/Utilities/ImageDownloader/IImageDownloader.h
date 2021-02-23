//
//  IImageDownloader.h
//  Boozter
//
//  Created by Ivan Bukshev on 23/10/2019.
//  Copyright © 2019 Team Absurdum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImageDownloadCompletion.h"

NS_ASSUME_NONNULL_BEGIN

@protocol IImageDownloader <NSObject>

- (void)downloadImageFromURL:(NSURL *)url
                   indexPath:(nullable NSIndexPath *)indexPath
           completionHandler:(ImageForIndexPathDownloadCompletion)completionHandler;

- (void)downloadImageFromURL:(NSURL *)url
           completionHandler:(ImageDownloadCompletion)completionHandler;

- (void)slowDownImageDownloadingFromURL:(NSURL *)url;

- (void)cancelAllOperations;

- (void)invalidateCache;

@end

NS_ASSUME_NONNULL_END

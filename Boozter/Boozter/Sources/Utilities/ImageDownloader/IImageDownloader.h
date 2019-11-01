//
//  IImageDownloader.h
//  Boozter
//
//  Created by Ivan Bukshev on 23/10/2019.
//  Copyright © 2019 Team Absurdum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImageDownloadCompletion.h"

@protocol IErrorProcessor;

NS_ASSUME_NONNULL_BEGIN

@protocol IImageDownloader <NSObject>

- (void)downloadImageFromURL:(NSURL *)url
                   indexPath:(nullable NSIndexPath *)indexPath
           completionHandler:(ImageDownloadCompletion)completionHandler
              errorProcessor:(id<IErrorProcessor>)errorProcessor;

- (void)slowDownImageDownloadingFromURL:(NSURL *)url;

- (void)cancelAllOperations;

@end

NS_ASSUME_NONNULL_END

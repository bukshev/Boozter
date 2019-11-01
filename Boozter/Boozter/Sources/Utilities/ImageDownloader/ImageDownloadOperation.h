//
//  ImageDownloadOperation.h
//  Boozter
//
//  Created by Ivan Bukshev on 23/10/2019.
//  Copyright © 2019 Team Absurdum. All rights reserved.
//

#import "NetworkOperation.h"
#import "ImageDownloadCompletion.h"

NS_ASSUME_NONNULL_BEGIN

@interface ImageDownloadOperation : NetworkOperation

@property (nonatomic, strong, readonly) NSURL *url;
@property (nonatomic, strong, readonly) NSIndexPath *indexPath;
@property (nonatomic, copy, readonly) ImageDownloadCompletion completionHandler;

- (instancetype)initWithURL:(NSURL *)url
                  indexPath:(NSIndexPath *)indexPath
          completionHandler:(ImageDownloadCompletion)completionHandler
             errorProcessor:(id<IErrorProcessor>)errorProcessor NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END

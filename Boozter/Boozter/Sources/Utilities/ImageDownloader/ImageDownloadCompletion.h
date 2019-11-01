//
//  ImageDownloadCompletion.h
//  Boozter
//
//  Created by Ivan Bukshev on 23/10/2019.
//  Copyright © 2019 Team Absurdum. All rights reserved.
//

@class NSURL;
@class NSIndexPath;
@class NSError;

#ifndef ImageDownloadCompletion_h
#define ImageDownloadCompletion_h

NS_ASSUME_NONNULL_BEGIN

typedef void (^ImageDownloadCompletion)(NSData * _Nullable , NSURL *, NSIndexPath *, NSError * _Nullable);

NS_ASSUME_NONNULL_END

#endif /* ImageDownloadCompletion_h */

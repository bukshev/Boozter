//
//  ImageDownloader.h
//  Boozter
//
//  Created by Ivan Bukshev on 23/10/2019.
//  Copyright © 2019 Team Absurdum. All rights reserved.
//

#import "IImageDownloader.h"

NS_ASSUME_NONNULL_BEGIN

@interface ImageDownloader : NSObject<IImageDownloader>

+ (instancetype)sharedInstance;

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END

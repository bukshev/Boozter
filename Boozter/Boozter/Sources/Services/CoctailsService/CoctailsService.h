//
//  CoctailsService.h
//  Boozter
//
//  Created by Ivan Bukshev on 06/09/2019.
//  Copyright © 2019 Team Absurdum. All rights reserved.
//

#import "ICoctailsService.h"

@protocol ICoreCache;
@protocol ICoreNetwork;

NS_ASSUME_NONNULL_BEGIN

@interface CoctailsService : NSObject <ICoctailsService>

- (instancetype)initWithCoreCache:(id<ICoreCache>)coreCache
                      coreNetwork:(id<ICoreNetwork>)coreNetwork NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END

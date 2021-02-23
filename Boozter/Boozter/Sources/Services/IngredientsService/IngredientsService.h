//
//  IngredientsService.h
//  Boozter
//
//  Created by Букшев Иван Евгеньевич on 19.02.2021.
//  Copyright © 2021 Team Absurdum. All rights reserved.
//

#import "IIngredientsService.h"

@protocol ICoreCache;
@protocol ICoreNetwork;

NS_ASSUME_NONNULL_BEGIN

@interface IngredientsService : NSObject <IIngredientsService>

- (instancetype)initWithCoreCache:(id<ICoreCache>)coreCache
                      coreNetwork:(id<ICoreNetwork>)coreNetwork NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END

//
//  ICoctailsService.h
//  Boozter
//
//  Created by Ivan Bukshev on 06/09/2019.
//  Copyright © 2019 Team Absurdum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataSourcePoint.h"
#import "ImageDownloadCompletion.h"

@class Coctail;

typedef void (^ObtainCoctailsCompletion)(NSArray<Coctail *> * _Nullable, NSError * _Nullable);
typedef void (^ObtainCoctailWithDetailsCompletion)(Coctail * _Nullable, NSError * _Nullable);

NS_ASSUME_NONNULL_BEGIN

@protocol ICoctailsService <NSObject>

@required
- (void)cacheCoctails:(NSArray<Coctail *> *)coctails;

- (void)obtainCoctailsFromSourcePoint:(DataSourcePoint)sourcePoint
                        withPredicate:(nullable NSPredicate *)predicate
                    completionHandler:(ObtainCoctailsCompletion)completionHandler;

- (void)obtainDetailsForCoctail:(NSInteger)coctailIdentifier
              completionHandler:(ObtainCoctailWithDetailsCompletion)completionHandler;

@end

NS_ASSUME_NONNULL_END

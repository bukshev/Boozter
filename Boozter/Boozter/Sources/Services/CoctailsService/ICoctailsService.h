//
//  ICoctailsService.h
//  Boozter
//
//  Created by Ivan Bukshev on 06/09/2019.
//  Copyright © 2019 Team Absurdum. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Coctail;

typedef void (^CoctailsServiceObtainingCallback)(NSArray<Coctail *> * _Nullable, NSError * _Nullable);

NS_ASSUME_NONNULL_BEGIN

@protocol ICoctailsService <NSObject>

@required
- (void)cacheCoctails:(NSArray<Coctail *> *)coctails;
- (void)obtainCachedCoctailsWithPredicate:(nullable NSPredicate *)predicate
                                 callback:(CoctailsServiceObtainingCallback)callback;

@end

NS_ASSUME_NONNULL_END

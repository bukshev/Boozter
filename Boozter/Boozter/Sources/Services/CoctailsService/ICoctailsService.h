//
//  ICoctailsService.h
//  Boozter
//
//  Created by Ivan Bukshev on 06/09/2019.
//  Copyright © 2019 Team Absurdum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImageDownloadCompletion.h"

@class Coctail;
@class Ingredient;

NS_ASSUME_NONNULL_BEGIN

typedef void (^ObtainCoctailsCompletion)(NSArray<Coctail *> * _Nullable, NSError * _Nullable);
typedef void (^ObtainCoctailDetailsCompletion)(Coctail * _Nullable, NSError * _Nullable);
typedef void (^ChangeCoctailFavoritedStateCompletion)(Coctail *, NSError * _Nullable);

@protocol ICoctailsService <NSObject>

@required
- (void)cacheCoctails:(NSArray<Coctail *> *)coctails;

- (void)obtainRemoteCoctailsWithIngredient:(Ingredient *)ingredient
                         completionHandler:(ObtainCoctailsCompletion)completionHandler;

- (void)obtainCachedCoctailsWithPredicate:(nullable NSPredicate *)predicate
                        completionHandler:(ObtainCoctailsCompletion)completionHandler;

- (void)obtainDetailsForCoctail:(NSInteger)coctailIdentifier
              completionHandler:(ObtainCoctailDetailsCompletion)completionHandler;

- (void)setFavoritedState:(BOOL)favorited
               forCoctail:(Coctail *)coctail
        completionHandler:(ChangeCoctailFavoritedStateCompletion)completionHandler;

@end

NS_ASSUME_NONNULL_END

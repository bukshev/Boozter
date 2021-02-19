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

NS_ASSUME_NONNULL_BEGIN

typedef void (^ObtainCoctailsCompletion)(NSArray<Coctail *> * _Nullable, NSError * _Nullable);
typedef void (^ObtainCoctailWithDetailsCompletion)(Coctail * _Nullable, NSError * _Nullable);

@protocol ICoctailsService <NSObject>

@required
- (void)cacheCoctails:(NSArray<Coctail *> *)coctails;

- (void)obtainRemoteCoctailsWithIngredientName:(NSString *)ingredientName
                             completionHandler:(ObtainCoctailsCompletion)completionHandler;

- (void)obtainDetailsForCoctail:(NSInteger)coctailIdentifier
              completionHandler:(ObtainCoctailWithDetailsCompletion)completionHandler;

@end

NS_ASSUME_NONNULL_END

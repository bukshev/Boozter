//
//  IIngredientsService.h
//  Boozter
//
//  Created by Букшев Иван Евгеньевич on 19.02.2021.
//  Copyright © 2021 Team Absurdum. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^ObtainIngredientsCompletion)(NSArray<NSString *> * _Nullable, NSError * _Nullable);

@protocol IIngredientsService <NSObject>

@required
- (void)obtainAvailableIngredients:(ObtainIngredientsCompletion)completionHandler;

@end

NS_ASSUME_NONNULL_END

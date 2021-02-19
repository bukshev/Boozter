//
//  IIngredientsInteractorOutput.h
//  Boozter
//
//  Created by Букшев Иван Евгеньевич on 19.02.2021.
//  Copyright © 2021 Team Absurdum. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol IIngredientsInteractorOutput <NSObject>

- (void)didObtainIngredients:(NSArray<NSString *> *)ingredients;
- (void)didFailObtainIngredientsWithError:(NSError *)error;

@end

NS_ASSUME_NONNULL_END

//
//  IngredientsFilter.h
//  Boozter
//
//  Created by Букшев Иван Евгеньевич on 19.02.2021.
//  Copyright © 2021 Team Absurdum. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IngredientsFilter : NSObject

- (instancetype)init;
- (instancetype)initWithIngredientsSet:(NSSet<NSString *> *)ingredients NS_DESIGNATED_INITIALIZER;

- (void)replaceAllIngredientsWithSet:(NSSet<NSString *> *)allIngredients;
- (void)replaceSelectedIngredientsWithSet:(NSSet<NSString *> *)selectedIngredients;

- (NSSet<NSString *> *)selectedIngredients;
- (NSSet<NSString *> *)allIngredients;

@end

NS_ASSUME_NONNULL_END

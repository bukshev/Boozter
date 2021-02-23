//
//  IngredientsViewController.h
//  Boozter
//
//  Created by Букшев Иван Евгеньевич on 19.02.2021.
//  Copyright © 2021 Team Absurdum. All rights reserved.
//

#import <UIKit/UIViewController.h>
#import "IIngredientsViewInput.h"

@protocol IIngredientsViewOutput;

@class IngredientsDataSource;

NS_ASSUME_NONNULL_BEGIN

@interface IngredientsViewController : UIViewController <IIngredientsViewInput>

@property (nonatomic, strong, readonly) id<IIngredientsViewOutput> output;

- (void)injectOutput:(id<IIngredientsViewOutput>)output;
- (void)injectDataSource:(IngredientsDataSource *)dataSource;

@end

NS_ASSUME_NONNULL_END

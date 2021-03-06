//
//  ICoctailModuleInput.h
//  Boozter
//
//  Created by Ivan Bukshev on 03/09/2019.
//  Copyright © 2019 Team Absurdum. All rights reserved.
//

#import <ViperMcFlurry/ViperMcFlurry.h>

@class Coctail;

NS_ASSUME_NONNULL_BEGIN

@protocol ICoctailModuleInput <RamblerViperModuleInput>

- (void)setCoctail:(Coctail *)coctail;

@end

NS_ASSUME_NONNULL_END

//
//  ServicesAssembly.h
//  Boozter
//
//  Created by Букшев Иван Евгеньевич on 04.02.2021.
//  Copyright © 2021 Team Absurdum. All rights reserved.
//

#import <Typhoon/Typhoon.h>

@protocol ICoctailsService;

NS_ASSUME_NONNULL_BEGIN

@interface ServicesAssembly : TyphoonAssembly

- (id<ICoctailsService>)coctailsService;

@end

NS_ASSUME_NONNULL_END

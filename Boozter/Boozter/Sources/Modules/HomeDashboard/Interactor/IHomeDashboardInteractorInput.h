//
//  IHomeDashboardInteractorInput.h
//  Boozter
//
//  Created by Ivan Bukshev on 02/09/2019.
//  Copyright © 2019 Team Absurdum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataSourcePoint.h"
#import "CoctailsFilter.h"

NS_ASSUME_NONNULL_BEGIN

@protocol IHomeDashboardInteractorInput <NSObject>

@required
- (void)obtainCoctailsFromSourcePoint:(DataSourcePoint)sourcePoint withFilter:(CoctailsFilter)filter;

@end

NS_ASSUME_NONNULL_END

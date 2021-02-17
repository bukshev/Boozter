//
//  IHomeDashboardInteractorInput.h
//  Boozter
//
//  Created by Ivan Bukshev on 02/09/2019.
//  Copyright © 2019 Team Absurdum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoctailsFilter.h"

NS_ASSUME_NONNULL_BEGIN

@protocol IHomeDashboardInteractorInput <NSObject>

@required
- (void)obtainRemoteCoctailsWithFilter:(CoctailsFilter)filter;

@end

NS_ASSUME_NONNULL_END

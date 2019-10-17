//
//  HomeDashboardItem.m
//  Boozter
//
//  Created by Ivan Bukshev on 02/09/2019.
//  Copyright © 2019 Team Absurdum. All rights reserved.
//

#import "HomeDashboardItem.h"
#import "Coctail.h"

@implementation HomeDashboardItem

#pragma mark - Initialization

- (instancetype)initWithCoctail:(Coctail *)coctail {
    assert(nil != coctail);

    self = [super init];

    if (nil != self) {
        _coctailName = coctail.name;
        _coctailImageURL = coctail.imageURL;
    }

    return self;
}

@end

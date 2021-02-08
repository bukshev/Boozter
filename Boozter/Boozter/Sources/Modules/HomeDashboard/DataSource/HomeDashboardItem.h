//
//  HomeDashboardItem.h
//  Boozter
//
//  Created by Ivan Bukshev on 02/09/2019.
//  Copyright © 2019 Team Absurdum. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Coctail;

NS_ASSUME_NONNULL_BEGIN

@interface HomeDashboardItem : NSObject

@property (nonatomic, strong, readonly) NSString *coctailName;
@property (nonatomic, strong, nullable, readwrite) NSData *coctailImageData;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithCoctail:(Coctail *)coctail NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END

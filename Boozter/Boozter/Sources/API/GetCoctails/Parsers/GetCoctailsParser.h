//
//  GetCoctailsParser.h
//  Boozter
//
//  Created by Ivan Bukshev on 17/10/2019.
//  Copyright © 2019 Team Absurdum. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Coctail;

NS_ASSUME_NONNULL_BEGIN

@interface GetCoctailsParser : NSObject

- (NSArray<Coctail *> *)coctailsFromDictionaries:(NSArray *)dictionaries;

@end

NS_ASSUME_NONNULL_END

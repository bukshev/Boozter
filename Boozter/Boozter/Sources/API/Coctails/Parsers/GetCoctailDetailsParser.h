//
//  GetCoctailDetailsParser.h
//  Boozter
//
//  Created by Букшев Иван Евгеньевич on 04.02.2021.
//  Copyright © 2021 Team Absurdum. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Coctail;

NS_ASSUME_NONNULL_BEGIN

@interface GetCoctailDetailsParser : NSObject

- (Coctail *)coctailFromNetworkResponseData:(NSData *)data;

@end

NS_ASSUME_NONNULL_END

//
//  GetIngredientDetailsParser.h
//  Boozter
//
//  Created by Букшев Иван Евгеньевич on 20.02.2021.
//  Copyright © 2021 Team Absurdum. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GetIngredientDetailsParser : NSObject

- (NSString *)ingredientDetailsFromNetworkResponseData:(NSData *)data;

@end

NS_ASSUME_NONNULL_END

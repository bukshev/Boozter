//
//  GetIngredientDetailsParser.m
//  Boozter
//
//  Created by Букшев Иван Евгеньевич on 20.02.2021.
//  Copyright © 2021 Team Absurdum. All rights reserved.
//

#import "GetIngredientDetailsParser.h"

@implementation GetIngredientDetailsParser

#pragma mark - Public interface

- (NSString *)ingredientDetailsFromNetworkResponseData:(NSData *)data {
    NSDictionary *json = [self jsonFromData:data];
    
    if (nil == json[@"ingredients"] || ![json[@"ingredients"] isKindOfClass:[NSArray class]]) {
        return @"Without additional information.";
    }

    NSDictionary *ingredientDictionary = [json[@"ingredients"] firstObject];

    if (nil == ingredientDictionary) {
        return nil;
    }

    return [self ingredientDetailsFromDictionary:ingredientDictionary];
}

#pragma mark - Private helpers

- (NSDictionary *)jsonFromData:(NSData *)data {
    return [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];;
}

- (NSString *)ingredientDetailsFromDictionary:(NSDictionary *)dictionary {
    NSString *description = dictionary[@"strDescription"];

    if (nil == description || ![description isKindOfClass:[NSString class]]) {
        return @"Without additional information.";
    }

    return description;
}

@end

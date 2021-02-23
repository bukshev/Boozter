//
//  GetIngredientsParser.m
//  Boozter
//
//  Created by Букшев Иван Евгеньевич on 19.02.2021.
//  Copyright © 2021 Team Absurdum. All rights reserved.
//

#import "GetIngredientsParser.h"

@implementation GetIngredientsParser

#pragma mark - Public interface

- (NSArray<NSString *> *)ingredientsFromNetworkResponseData:(NSData *)data {
    if (nil == data) {
        return [[NSArray array] copy];
    }

    NSDictionary *json = [self jsonFromData:data];
    NSArray *ingredientsList = json[@"drinks"];

    NSMutableArray<NSString *> *ingredients = [NSMutableArray arrayWithCapacity:ingredientsList.count];
    for (NSDictionary *dictionary in ingredientsList) {
        NSString *ingredient = [self ingredientFromDictionary:dictionary];
        [ingredients addObject:ingredient];
    }

    return [ingredients copy];
}

#pragma mark - Private helpers

- (NSDictionary *)jsonFromData:(NSData *)data {
    return [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];;
}

- (NSString *)ingredientFromDictionary:(NSDictionary *)dictionary {
    NSString *name = dictionary[@"strIngredient1"] ?: @"[unknown]";
    return name;
}

@end

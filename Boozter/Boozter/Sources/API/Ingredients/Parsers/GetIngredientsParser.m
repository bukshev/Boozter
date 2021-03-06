//
//  GetIngredientsParser.m
//  Boozter
//
//  Created by Букшев Иван Евгеньевич on 19.02.2021.
//  Copyright © 2021 Team Absurdum. All rights reserved.
//

#import "GetIngredientsParser.h"
#import "Ingredient.h"

@implementation GetIngredientsParser

#pragma mark - Public interface

- (NSArray<Ingredient *> *)ingredientsFromNetworkResponseData:(NSData *)data {
    if (nil == data) {
        return [[NSArray array] copy];
    }

    NSDictionary *json = [self jsonFromData:data];
    NSArray *ingredientsList = json[@"drinks"];

    NSMutableArray<Ingredient *> *ingredients = [NSMutableArray arrayWithCapacity:ingredientsList.count];
    for (NSDictionary *dictionary in ingredientsList) {
        Ingredient *ingredient = [self ingredientFromDictionary:dictionary];
        [ingredients addObject:ingredient];
    }

    return [ingredients copy];
}

#pragma mark - Private helpers

- (NSDictionary *)jsonFromData:(NSData *)data {
    return [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];;
}

- (Ingredient *)ingredientFromDictionary:(NSDictionary *)dictionary {
    NSString *name = dictionary[@"strIngredient1"] ?: @"[unknown]";
    Ingredient *ingredient = [[Ingredient alloc] initWithUUID:[NSUUID UUID] name:name measure:nil];
    return ingredient;
}

@end

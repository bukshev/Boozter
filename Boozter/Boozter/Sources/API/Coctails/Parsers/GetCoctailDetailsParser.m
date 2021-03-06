//
//  GetCoctailDetailsParser.m
//  Boozter
//
//  Created by Букшев Иван Евгеньевич on 04.02.2021.
//  Copyright © 2021 Team Absurdum. All rights reserved.
//

#import "GetCoctailDetailsParser.h"
#import "Coctail.h"
#import "Ingredient.h"

static int const MAX_INGREDIENTS_NUMBER = 15;

@implementation GetCoctailDetailsParser

#pragma mark - Public interface

- (Coctail *)coctailFromNetworkResponseData:(NSData *)data {
    NSDictionary *json = [self jsonFromData:data];
    NSDictionary *coctailDict = [json[@"drinks"] firstObject];

    if (nil == coctailDict) {
        return nil;
    }

    return [self coctailFromDictionary:coctailDict];
}

#pragma mark - Private helpers

- (NSDictionary *)jsonFromData:(NSData *)data {
    return [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];;
}

- (Coctail *)coctailFromDictionary:(NSDictionary *)dictionary {
    NSInteger identifier = [dictionary[@"idDrink"] integerValue] ?: -1;
    NSString *name = dictionary[@"strDrink"] ?: @"NULL";
    NSString *imageURLString = dictionary[@"strDrinkThumb"];
    NSURL *url = [NSURL URLWithString:imageURLString];

    Coctail *coctail = [[Coctail alloc] initWithIdentifier:identifier name:name imageURL:url];

    NSString *alcoholic = dictionary[@"strAlcoholic"] ?: @"Unknown";
    NSString *category = dictionary[@"strCategory"] ?: @"Unknown";
    NSString *glassName = dictionary[@"strGlass"] ?: @"Unknown";
    NSString *instructions = dictionary[@"strInstructions"] ?: @"Unknown";

    [coctail updateAlcoholic:alcoholic];
    [coctail updateCategory:category];
    [coctail updateGlassName:glassName];
    [coctail updateInstructions:instructions];

    NSArray<Ingredient *> *ingredients = [self ingredientsFromDictionary:dictionary];
    [coctail updateIngredients:ingredients];

    return coctail;
}

- (NSArray<Ingredient *> *)ingredientsFromDictionary:(NSDictionary *)dictionary {
    NSMutableArray<Ingredient *> *ingredients = [NSMutableArray arrayWithCapacity:MAX_INGREDIENTS_NUMBER];

    NSArray<NSString *> *names = [self allIngredientsFromDictionary:dictionary];
    NSArray<NSString *> *measures = [self allMeasuresFromDictionary:dictionary];

    for (NSInteger index = 1; index < names.count; index++) {
        NSString *name = names[index];
        NSString *_Nullable measure = (index < measures.count) ? measures[index] : nil;

        Ingredient *ingredient = [[Ingredient alloc] initWithUUID:[NSUUID UUID] name:name measure:measure];
        [ingredients addObject:ingredient];
    }

    return [ingredients copy];
}

- (NSArray<NSString *> *)allIngredientsFromDictionary:(NSDictionary *)dictionary {
    return [self valuesFromDictionary:dictionary withFormattedKey:@"strIngredient%ld"];
}

- (NSArray<NSString *> *)allMeasuresFromDictionary:(NSDictionary *)dictionary {
    return [self valuesFromDictionary:dictionary withFormattedKey:@"strMeasure%ld"];
}

- (NSArray<NSString *> *)valuesFromDictionary:(NSDictionary *)dictionary withFormattedKey:(NSString *)formatString {
    NSCharacterSet *whitespaces = [NSCharacterSet whitespaceCharacterSet];

    NSMutableArray<NSString *> *values = [NSMutableArray arrayWithCapacity:MAX_INGREDIENTS_NUMBER];
    for (NSInteger index = 1; index <= MAX_INGREDIENTS_NUMBER; index++) {
        NSString *key = [NSMutableString stringWithFormat:formatString, index];

        id rawValue = dictionary[key];
        if (nil == rawValue || [rawValue isKindOfClass:[NSNull class]]) {
            break;
        }

        NSString *stringValue = dictionary[key];
        if (stringValue.length < 1) {
            break;
        }

        NSString *value = [stringValue stringByTrimmingCharactersInSet:whitespaces];
        [values addObject:value];
    }

    return [values copy];
}

@end

//
//  GetCoctailsParser.m
//  Boozter
//
//  Created by Ivan Bukshev on 17/10/2019.
//  Copyright © 2019 Team Absurdum. All rights reserved.
//

#import "GetCoctailsParser.h"
#import "Coctail.h"

@implementation GetCoctailsParser

#pragma mark - Parsing

- (NSArray<Coctail *> *)coctailsFromDictionaries:(NSArray *)dictionaries {
    NSMutableArray<Coctail *> *coctails = [NSMutableArray arrayWithCapacity:dictionaries.count];

    for (NSDictionary *dictionary in dictionaries) {
        Coctail *coctail = [self coctailFromDictionary:dictionary];
        [coctails addObject:coctail];
    }

    return [coctails copy];
}

#pragma mark - Private helpers

- (Coctail *)coctailFromDictionary:(NSDictionary *)dictionary {
    NSInteger identifier = [dictionary[@"idDrink"] integerValue] ?: -1;
    NSString *name = dictionary[@"strDrink"] ?: @"NULL";
    NSString *imageURLString = dictionary[@"strDrinkThumb"];

    NSURL *url = [NSURL URLWithString:imageURLString];
    return [[Coctail alloc] initWithIdentifier:identifier name:name imageURL:url];
}

@end

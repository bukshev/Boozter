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

#pragma mark - Public interface

- (NSArray<Coctail *> *)coctailsFromNetworkResponseData:(NSData *)data {
    if (nil == data) {
        return [[NSArray array] copy];
    }

    NSDictionary *json = [self jsonFromData:data];
    NSDictionary *coctailsList = json[@"drinks"];

    NSMutableArray<Coctail *> *coctails = [NSMutableArray arrayWithCapacity:coctailsList.count];
    for (NSDictionary *dictionary in coctailsList) {
        Coctail *coctail = [self coctailFromDictionary:dictionary];
        [coctails addObject:coctail];
    }

    return [coctails copy];
    
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
    return [[Coctail alloc] initWithIdentifier:identifier name:name imageURL:url];
}

@end

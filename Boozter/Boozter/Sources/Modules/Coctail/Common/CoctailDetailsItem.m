//
//  CoctailDetailsItem.m
//  Boozter
//
//  Created by Букшев Иван Евгеньевич on 03.02.2021.
//  Copyright © 2021 Team Absurdum. All rights reserved.
//

#import "CoctailDetailsItem.h"
#import "Coctail.h"

@implementation CoctailDetailsItem

#pragma mark - Initialization

- (instancetype)initWithCoctail:(Coctail *)coctail {
    assert(nil != coctail);

    self = [super init];

    if (nil != self) {
        _name = [coctail.name copy];
        _imageData = coctail.imageData;
        _alcoholic = [coctail.alcoholic copy];
        _category = [coctail.category copy];
        _glassName = [coctail.glassName copy];
        _instructions = [coctail.instructions copy];
        _measuredIngredientsText = [self measuredIngredientsTextForArray:coctail.measuredIngredients];
    }

    return self;
}

- (NSString *)measuredIngredientsTextForArray:(NSArray<NSString *> *)array {
    NSMutableString *resultString = [NSMutableString string];

    for (NSString *measuredIngredient in array) {
        [resultString appendString:measuredIngredient];
        [resultString appendString:@"\n"];
    }

    return [resultString copy];
}

@end

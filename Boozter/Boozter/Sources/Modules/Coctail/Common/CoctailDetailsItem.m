//
//  CoctailDetailsItem.m
//  Boozter
//
//  Created by Букшев Иван Евгеньевич on 03.02.2021.
//  Copyright © 2021 Team Absurdum. All rights reserved.
//

#import "CoctailDetailsItem.h"
#import "Coctail.h"
#import "Ingredient.h"

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
        _measuredIngredientsText = [self measuredIngredientsTextForArray:coctail.ingredients];
    }

    return self;
}

- (NSString *)measuredIngredientsTextForArray:(NSArray<Ingredient *> *)array {
    NSMutableString *resultString = [NSMutableString string];

    for (NSInteger index = 0; index < array.count; index++) {
        Ingredient *ingredient = array[index];

        if (nil != ingredient.measure) {
            NSString *line = [NSString stringWithFormat:@"%ld. %@ (%@).", index + 1, ingredient.name, ingredient.measure];
            [resultString appendString:line];
        } else {
            NSString *line = [NSString stringWithFormat:@"%ld. %@.", index + 1, ingredient.name];
            [resultString appendString:line];
        }

        [resultString appendString:@"\n"];
    }

    return [resultString copy];
}

@end

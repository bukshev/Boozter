//
//  Ingredient.m
//  Boozter
//
//  Created by Букшев Иван Евгеньевич on 06.03.2021.
//  Copyright © 2021 Team Absurdum. All rights reserved.
//

#import "Ingredient.h"
#import "ManagedIngredient.h"

@implementation Ingredient

#pragma mark - Initialization

+ (instancetype)defaultIngredient {
    return [[Ingredient alloc] initWithUUID:[NSUUID UUID] name:@"Vodka" measure:nil];
}

- (instancetype)initWithUUID:(NSUUID *)uuid name:(NSString *)name measure:(nullable NSString *)measure {
    assert(nil != name);

    if (nil != self) {
        _uuid = uuid;
        _name = [name copy];

        if (nil != measure) {
            _measure = [measure copy];
        }
    }

    return self;
}

#pragma mark - IPlainObject

- (NSString *)entityName {
    return NSStringFromClass([self class]);
}

- (instancetype)initWithManagedObject:(NSManagedObject *)managedObject {
    assert(nil != managedObject);
    assert([managedObject isKindOfClass:[ManagedIngredient class]]);

    ManagedIngredient *managedIngredient = (ManagedIngredient *)managedObject;

    assert(nil != managedIngredient.uuid);
    assert(nil != managedIngredient.name);

    Ingredient *ingredient = [self initWithUUID:managedIngredient.uuid
                                           name:managedIngredient.name
                                        measure:managedIngredient.measure];

    return ingredient;
}

@end

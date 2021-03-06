//
//  IngredientCacheModelFiller.m
//  Boozter
//
//  Created by Букшев Иван Евгеньевич on 06.03.2021.
//  Copyright © 2021 Team Absurdum. All rights reserved.
//

#import "IngredientCacheModelFiller.h"
#import <CoreData/NSEntityDescription.h>
#import "ManagedIngredient.h"
#import "NSManagedObject+EntityName.h"
#import "Ingredient.h"

@implementation IngredientCacheModelFiller

#pragma mark - ICoreCacheModelFiller

- (void)fillWithPlainObject:(NSObject<IPlainObject> *)object inContext:(NSManagedObjectContext *)context {
    assert(nil != object);
    assert(nil != context);
    NSAssert([object isKindOfClass:[Ingredient class]], @"Plain Object is not Ingredient entity.");

    Ingredient *ingredient = (Ingredient *)object;

    NSString *entityName = [ManagedIngredient entityName];
    NSManagedObject *managedObject = [NSEntityDescription insertNewObjectForEntityForName:entityName
                                                                   inManagedObjectContext:context];

    assert([managedObject isKindOfClass:[ManagedIngredient class]]);
    ManagedIngredient *managedIngredient = (ManagedIngredient *)managedObject;

    managedIngredient.uuid = ingredient.uuid;
    managedIngredient.name = [ingredient.name copy];

    if (nil != ingredient.measure) {
        managedIngredient.measure = [ingredient.measure copy];
    }
}


@end

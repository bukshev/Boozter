//
//  Coctail.m
//  Boozter
//
//  Created by Ivan Bukshev on 02/09/2019.
//  Copyright © 2019 Team Absurdum. All rights reserved.
//

#import "Coctail.h"
#import "ManagedCoctail.h"
#import "Ingredient.h"

@implementation Coctail

#pragma mark - Initialization

- (instancetype)initWithIdentifier:(NSInteger)identifier name:(NSString *)name imageURL:(NSURL *)imageURL {
    assert(nil != name);

    self = [super init];

    if (nil != self) {
        _identifier = identifier;
        _name = [name copy];
        _imageURL = [imageURL copy];
    }

    return self;
}

#pragma mark - Update state

- (BOOL)hasDetails {
    return (nil != self.glassName)
        && (nil != self.instructions)
        && (nil != self.ingredients);
}

- (void)updateImageData:(nullable NSData *)imageData {
    if (nil != imageData) {
        _imageData = imageData;
    }
}

- (void)updateAlcoholic:(nullable NSString *)alcoholic {
    if (nil != alcoholic) {
        _alcoholic = [alcoholic copy];
    }
}

- (void)updateCategory:(nullable NSString *)category {
    if (nil != category) {
        _category = [category copy];
    }
}

- (void)updateGlassName:(nullable NSString *)glassName {
    if (nil != glassName) {
        _glassName = [glassName copy];
    }
}

- (void)updateInstructions:(nullable NSString *)instructions {
    if (nil != instructions) {
        _instructions = [instructions copy];
    }
}

- (void)updateIngredients:(nullable NSArray<NSString *> *)ingredients {
    if (nil != ingredients) {
        _ingredients = [ingredients copy];
    }
}

#pragma mark - IPlainObject

- (instancetype)initWithManagedObject:(NSManagedObject *)managedObject {
    assert(nil != managedObject);
    assert([managedObject isKindOfClass:[ManagedCoctail class]]);

    ManagedCoctail *managedCoctail = (ManagedCoctail *)managedObject;

    assert(nil != managedCoctail.imageURLString);
    assert(-1 < managedCoctail.identifier);
    assert(nil != managedCoctail.name);

    NSURL *url = [NSURL URLWithString:managedCoctail.imageURLString];

    Coctail *coctail = [self initWithIdentifier:managedCoctail.identifier name:managedCoctail.name imageURL:url];
    [coctail updateGlassName:managedCoctail.glassName];
    [coctail updateInstructions:managedCoctail.instructions];

    if (nil != managedCoctail.ingredients && managedCoctail.ingredients.count > 0) {
        NSMutableArray *plainIngredients = [NSMutableArray arrayWithCapacity:managedCoctail.ingredients.count];
        [managedCoctail.ingredients enumerateObjectsUsingBlock:^(ManagedIngredient *managedIngredient, NSUInteger idx, BOOL *stop) {
            Ingredient *plainIngredient = [[Ingredient alloc] initWithManagedObject:managedIngredient];
            [plainIngredients addObject:plainIngredient];
        }];
        [coctail updateIngredients:plainIngredients];
    }

    return coctail;
}

@end

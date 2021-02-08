//
//  Coctail.m
//  Boozter
//
//  Created by Ivan Bukshev on 02/09/2019.
//  Copyright © 2019 Team Absurdum. All rights reserved.
//

#import "Coctail.h"
#import "ManagedCoctail.h"

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
        && (nil != self.measuredIngredients);
}

- (void)updateImageData:(nullable NSData *)imageData {
    _imageData = imageData;
}

- (void)updateAlcoholic:(nullable NSString *)alcoholic {
    _alcoholic = [alcoholic copy];
}

- (void)updateCategory:(nullable NSString *)category {
    _category = [category copy];
}

- (void)updateGlassName:(nullable NSString *)glassName {
    _glassName = [glassName copy];
}

- (void)updateInstructions:(nullable NSString *)instructions {
    _instructions = [instructions copy];
}

- (void)updateMeasuredIngredients:(nullable NSArray<NSString *> *)measuredIngredients {
    _measuredIngredients = [measuredIngredients copy];
}

#pragma mark - IPlainObject

- (instancetype)initWithManagedObject:(ManagedCoctail *)managedObject {
    assert(nil != managedObject);

    NSURL *url = [NSURL URLWithString:managedObject.imageURLString];

    Coctail *coctail = [self initWithIdentifier:managedObject.identifier name:managedObject.name imageURL:url];
    [coctail updateGlassName:managedObject.glassName];
    [coctail updateInstructions:managedObject.instructions];
    [coctail updateMeasuredIngredients:managedObject.measuredIngredients];

    return coctail;
}

@end

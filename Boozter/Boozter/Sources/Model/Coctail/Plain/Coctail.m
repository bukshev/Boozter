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

#pragma mark - IPlainObject

- (instancetype)initWithManagedObject:(ManagedCoctail *)managedObject {
    assert(nil != managedObject);

    NSURL *url = [NSURL URLWithString:managedObject.imageURLString];
    return [self initWithIdentifier:managedObject.identifier name:managedObject.name imageURL:url];
}

@end

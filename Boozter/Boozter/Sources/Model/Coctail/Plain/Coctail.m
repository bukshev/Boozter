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

- (instancetype)initWithUUID:(NSUUID *)uuid name:(NSString *)name imageURL:(NSURL *)imageURL {
    assert(nil != uuid);
    assert(nil != name);

    self = [super init];

    if (nil != self) {
        _uuid = [uuid copy];
        _name = [name copy];
        _imageURL = [imageURL copy];
    }

    return self;
}

#pragma mark - IPlainObject

- (instancetype)initWithManagedObject:(ManagedCoctail *)managedObject {
    assert(nil != managedObject);

    NSURL *url = [NSURL URLWithString:managedObject.imageURLString];
    return [self initWithUUID:managedObject.uuid name:managedObject.name imageURL:url];
}

@end

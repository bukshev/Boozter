//
//  NSManagedObject+EntityName.m
//  Boozter
//
//  Created by Ivan Bukshev on 17/10/2019.
//  Copyright © 2019 Team Absurdum. All rights reserved.
//

#import "NSManagedObject+EntityName.h"

@implementation NSManagedObject (EntityName)

+ (NSString *)entityName {
    return [NSStringFromClass(self) stringByReplacingOccurrencesOfString:@"Managed"
                                                              withString:@""];
}

- (NSString *)entityName {
    return [[self class] entityName];
}

@end

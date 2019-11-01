//
//  Coctail.h
//  Boozter
//
//  Created by Ivan Bukshev on 02/09/2019.
//  Copyright © 2019 Team Absurdum. All rights reserved.
//

#import "IPlainObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface Coctail : NSObject<IPlainObject>

@property (nonatomic, assign, readonly) NSInteger identifier;
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, strong, nullable, readonly) NSURL *imageURL;
@property (nonatomic, strong, nullable, readwrite) NSData *imageData;

- (instancetype)initWithIdentifier:(NSInteger)identifier
                              name:(NSString *)name
                          imageURL:(nullable NSURL *)imageURL NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END

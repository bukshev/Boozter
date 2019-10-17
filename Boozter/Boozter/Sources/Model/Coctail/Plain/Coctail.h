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

@property (nonatomic, copy, readonly) NSUUID *uuid;
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, nullable, readonly) NSURL *imageURL;

- (instancetype)initWithUUID:(NSUUID *)uuid
                        name:(NSString *)name
                    imageURL:(nullable NSURL *)imageURL NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END

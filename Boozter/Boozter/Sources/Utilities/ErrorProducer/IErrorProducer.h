//
//  IErrorProducer.h
//  Boozter
//
//  Created by Букшев Иван Евгеньевич on 22.01.2021.
//  Copyright © 2021 Team Absurdum. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol IErrorProducer <NSObject>

- (NSError *)nilStrongSelfEntityError;

@end

NS_ASSUME_NONNULL_END

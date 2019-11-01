//
//  CoreNetwork.m
//  Boozter
//
//  Created by Ivan Bukshev on 17/10/2019.
//  Copyright © 2019 Team Absurdum. All rights reserved.
//

#import "CoreNetwork.h"
#import "NetworkOperationQueue.h"

@interface CoreNetwork ()
@property (nonatomic, strong) NetworkOperationQueue *queue;
@end

@implementation CoreNetwork

- (instancetype)initWithQueue:(NetworkOperationQueue *)queue {
    self = [super init];

    if (nil != self) {
        _queue = queue;
    }

    return self;
}

- (void)executeOperation:(NetworkOperation *)operation {
    [self.queue addOperation:operation];
}

@end

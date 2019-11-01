//
//  NetworkOperationQueue.m
//  Boozter
//
//  Created by Ivan Bukshev on 17/10/2019.
//  Copyright © 2019 Team Absurdum. All rights reserved.
//

#import "NetworkOperationQueue.h"

@interface NetworkOperationQueue ()
@property (nonatomic, strong) NSOperationQueue *queue;
@end

@implementation NetworkOperationQueue

#pragma mark - Initialization

+ (instancetype)sharedInstance
{
    static NetworkOperationQueue *sharedInstance = nil;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        sharedInstance = [[NetworkOperationQueue alloc] init];
    });

    return sharedInstance;
}

- (instancetype)init {
    self = [super init];

    if (nil != self) {
        _queue = [[NSOperationQueue alloc] init];
    }

    return self;
}

#pragma mark - Public Interface

- (void)addOperation:(NSOperation *)operation {
    [self.queue addOperation:operation];
}

@end

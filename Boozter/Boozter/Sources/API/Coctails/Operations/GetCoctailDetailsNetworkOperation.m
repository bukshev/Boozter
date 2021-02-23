//
//  GetCoctailDetailsNetworkOperation.m
//  Boozter
//
//  Created by Букшев Иван Евгеньевич on 04.02.2021.
//  Copyright © 2021 Team Absurdum. All rights reserved.
//

#import "GetCoctailDetailsNetworkOperation.h"
#import "GetCoctailDetailsParser.h"

@interface GetCoctailDetailsNetworkOperation ()
@property (nonatomic, strong) GetCoctailDetailsParser *parser;
@property (nonatomic, copy) void (^completion)(Coctail *coctails);
@end

@implementation GetCoctailDetailsNetworkOperation

@synthesize name = _name;

#pragma mark - Initialization

- (instancetype)initWithURL:(NSURL *)url
                 completion:(void (^)(Coctail *))completion {

    assert(nil != url);
    assert(NULL != completion);

    self = [super initWithURL:url];

    if (nil != self) {
        _name = @"GetCoctailDetailsNetworkOperation";
        _parser = [[GetCoctailDetailsParser alloc] init];
        _completion = completion;
    }

    return self;
}

#pragma mark - NSOperation

- (void)start {
    [super start];

    NSURLSession *session = [NSURLSession sharedSession];

    void (^completionHandler)(NSData *, NSURLResponse *, NSError *) = ^(NSData *data, NSURLResponse *response, NSError *error) {
        if (nil != error) {
            // TODO: Add error handling here...
            return;
        }

        Coctail *coctail = [self.parser coctailFromNetworkResponseData:data];
        if (self.completion) {
            self.completion(coctail);
        }

        [self finish];
    };

    NSURLSessionDataTask *task = [session dataTaskWithURL:self.url completionHandler:completionHandler];
    [task resume];
}

- (void)cancel {
    [super cancel];
    [self finish];
}

@end

//
//  GetCoctailsNetworkOperation.m
//  Boozter
//
//  Created by Ivan Bukshev on 17/10/2019.
//  Copyright © 2019 Team Absurdum. All rights reserved.
//

#import "GetCoctailsNetworkOperation.h"
#import "GetCoctailsParser.h"

@interface GetCoctailsNetworkOperation ()
@property (nonatomic, strong) GetCoctailsParser *parser;
@property (nonatomic, copy) void (^completion)(NSArray<Coctail *> *coctails);
@end

@implementation GetCoctailsNetworkOperation

@synthesize name = _name;

#pragma mark - Initialization

- (instancetype)initWithURL:(NSURL *)url
                 completion:(void (^)(NSArray<Coctail *> *))completion {

    assert(nil != url);
    assert(NULL != completion);

    self = [super initWithURL:url];

    if (nil != self) {
        _name = @"GetCoctailsNetworkOperation";
        _parser = [[GetCoctailsParser alloc] init];
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
            return;
        }

        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray<Coctail *> *coctails = [self.parser coctailsFromDictionaries:json[@"drinks"]];
        if (self.completion) {
            self.completion(coctails);
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

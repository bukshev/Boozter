//
//  GetIngredientsNetworkOperation.m
//  Boozter
//
//  Created by Букшев Иван Евгеньевич on 19.02.2021.
//  Copyright © 2021 Team Absurdum. All rights reserved.
//

#import "GetIngredientsNetworkOperation.h"
#import "GetIngredientsParser.h"
#import "Ingredient.h"

@interface GetIngredientsNetworkOperation ()
@property (nonatomic, strong) GetIngredientsParser *parser;
@property (nonatomic, copy) void (^completion)(NSArray<Ingredient *> *ingredients);
@end

@implementation GetIngredientsNetworkOperation

@synthesize name = _name;

#pragma mark - Initialization

- (instancetype)initWithCompletion:(void (^)(NSArray<Ingredient *> * _Nonnull))completion {
    assert(NULL != completion);

    NSURL *url = [NSURL URLWithString:@"https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list"];

    self = [super initWithURL:url];

    if (nil != self) {
        _name = @"GetIngredientsNetworkOperation";
        _parser = [[GetIngredientsParser alloc] init];
        _completion = [completion copy];
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

        NSArray<Ingredient *> *ingredients = [self.parser ingredientsFromNetworkResponseData:data];
        if (self.completion) {
            self.completion(ingredients);
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

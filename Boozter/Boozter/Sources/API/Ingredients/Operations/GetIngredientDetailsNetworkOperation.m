//
//  GetIngredientDetailsNetworkOperation.m
//  Boozter
//
//  Created by Букшев Иван Евгеньевич on 20.02.2021.
//  Copyright © 2021 Team Absurdum. All rights reserved.
//

#import "GetIngredientDetailsNetworkOperation.h"
#import "GetIngredientDetailsParser.h"

@interface GetIngredientDetailsNetworkOperation ()
@property (nonatomic, strong) GetIngredientDetailsParser *parser;
@property (nonatomic, copy) void (^completion)(NSString *ingredientDetails);
@end

@implementation GetIngredientDetailsNetworkOperation

@synthesize name = _name;

#pragma mark - Initialization

- (instancetype)initWithIngredientName:(NSString *)ingredientName completion:(void (^)(NSString * _Nonnull))completion {
    assert(nil != ingredientName);
    assert(NULL != completion);

    NSString *formattedName = [ingredientName stringByReplacingOccurrencesOfString:@" " withString:@"_"];
    NSString *urlString = [NSString stringWithFormat:@"https://www.thecocktaildb.com/api/json/v1/1/search.php?i=%@", formattedName];
    NSURL *url = [NSURL URLWithString:urlString];

    self = [super initWithURL:url];

    if (nil != self) {
        _name = @"GetIngredientDetailsNetworkOperation";
        _parser = [[GetIngredientDetailsParser alloc] init];
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

        NSString *ingredientDetails = [self.parser ingredientDetailsFromNetworkResponseData:data];
        if (self.completion) {
            self.completion(ingredientDetails);
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

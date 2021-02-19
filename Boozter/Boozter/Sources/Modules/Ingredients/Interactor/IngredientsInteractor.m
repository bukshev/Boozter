//
//  IngredientsInteractor.m
//  Boozter
//
//  Created by Букшев Иван Евгеньевич on 19.02.2021.
//  Copyright © 2021 Team Absurdum. All rights reserved.
//

#import "IngredientsInteractor.h"
#import "IIngredientsInteractorOutput.h"
#import "IIngredientsService.h"

@interface IngredientsInteractor ()
@property (nonatomic, strong) id<IIngredientsService> ingredientsService;
@end

@implementation IngredientsInteractor

#pragma mark - Initialization

- (instancetype)initWithIngredientsService:(id<IIngredientsService>)ingredientsService {
    assert(nil != ingredientsService);

    self = [super init];

    if (nil != self) {
        _ingredientsService = ingredientsService;
    }

    return self;
}

- (void)injectOutput:(id<IIngredientsInteractorOutput>)output {
    _output = output;
}

@end

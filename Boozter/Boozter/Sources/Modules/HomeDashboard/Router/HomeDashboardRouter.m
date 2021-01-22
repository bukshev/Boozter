//
//  HomeDashboardRouter.m
//  Boozter
//
//  Created by Ivan Bukshev on 02/09/2019.
//  Copyright © 2019 Team Absurdum. All rights reserved.
//

#import "HomeDashboardRouter.h"
#import <ViperMcFlurry/ViperMcFlurry.h>
#import "IModuleFactory.h"
#import "IModuleTransitionHandler.h"

@interface HomeDashboardRouter ()
@property (nonatomic, strong) id<IModuleFactory> coctailModuleFactory;
@end

@implementation HomeDashboardRouter

#pragma mark - Initialization

- (instancetype)initWithCoctailModuleFactory:(id<IModuleFactory>)coctailModuleFactory {
    assert(nil != coctailModuleFactory);

    self = [super init];

    if (nil != self) {
        _coctailModuleFactory = coctailModuleFactory;
    }

    return self;
}

- (void)injectTransitionHandler:(id<IModuleTransitionHandler>)transitionHandler {
    assert(nil != transitionHandler);
    _transitionHandler = transitionHandler;
}

#pragma mark - IHomeDashboardRouter

- (void)openDetailScreenWithCoctail:(Coctail *)coctail {
    assert(nil != coctail);
    
//    [[self.transitionHandler openModuleUsingFactory:self.coctailModuleFactory withTransitionBlock:^(id<IModuleTransitionHandler> sourceModuleTransitionHandler, id<IModuleTransitionHandler> destinationModuleTransitionHandler) {
//        UIViewController *sourceViewController = (UIViewController *)sourceModuleTransitionHandler;
//        UIViewController *destinationViewController = (UIViewController *)destinationModuleTransitionHandler;
//        [sourceViewController.navigationController pushViewController:destinationViewController animated:YES];
//    }] thenChainUsingBlock:^id<RamblerViperModuleOutput>(id<RamblerViperModuleInput> moduleInput) {
//        printf("afsgsdsdfs");
//        return nil;
//    }];
}

@end

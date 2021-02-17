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
#import "ICoctailModuleInput.h"

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
    
    [[self.transitionHandler openModuleUsingFactory:self.coctailModuleFactory
                                withTransitionBlock:^(id<RamblerViperModuleTransitionHandlerProtocol> source, id<RamblerViperModuleTransitionHandlerProtocol> destination) {

        UIViewController *sourceViewController = (UIViewController *)source;
        UIViewController *destinationViewController = (UIViewController *)destination;
        [sourceViewController.navigationController pushViewController:destinationViewController animated:YES];

    }] thenChainUsingBlock:^id<RamblerViperModuleOutput>(__kindof id<ICoctailModuleInput> moduleInput) {
        [moduleInput setCoctail:coctail];
        return nil;
    }];
}

@end

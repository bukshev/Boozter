//
//  IngredientsViewController.m
//  Boozter
//
//  Created by Букшев Иван Евгеньевич on 19.02.2021.
//  Copyright © 2021 Team Absurdum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IngredientsViewController.h"
#import "IIngredientsViewOutput.h"
#import "IngredientsDataSource.h"

#import "UIColor+Application.h"
#import "UINavigationController+StatusBarColor.h"

@interface IngredientsViewController () <UITableViewDelegate>
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IngredientsDataSource *dataSource;
@property (nonatomic, strong) UIVisualEffectView *blurEffectView;
@end

@implementation IngredientsViewController

#pragma mark - Initialization

- (void)injectOutput:(id<IIngredientsViewOutput>)output {
    _output = output;
}

- (void)injectDataSource:(IngredientsDataSource *)dataSource {
    _dataSource = dataSource;
}

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.output onViewReadyEvent:UIScreen.mainScreen.bounds.size];
}

#pragma mark - IIngredientsViewInput

- (void)setupInitialState {
    assert(nil != self.tableView);
    assert(nil != self.dataSource);

    self.tableView.delegate = self;
    [self.dataSource injectTableView:self.tableView];

    if (@available(iOS 13, *)) {
        UINavigationBarAppearance *appearance = [[UINavigationBarAppearance alloc] init];
        [appearance configureWithOpaqueBackground];
        appearance.backgroundColor = [UIColor navigationControllerBackgroundColor];
        self.navigationController.navigationBar.standardAppearance = appearance;
        self.navigationController.navigationBar.scrollEdgeAppearance = appearance;
        //        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        //        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    } else {
        [self.navigationController setStatusBarColor:[UIColor navigationControllerBackgroundColor]];
    }
}

- (void)reloadData {
    assert(NSThread.isMainThread);
    
    [self.tableView reloadData];
}

- (void)showBlurEffect {
    assert(NSThread.isMainThread);

    if (UIAccessibilityIsReduceTransparencyEnabled()) {
        return;
    }

    if (nil == _blurEffectView) {
        self.view.backgroundColor = [UIColor clearColor];

        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        self.blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];

        self.blurEffectView.frame = self.view.bounds;
        self.blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }

    self.blurEffectView.alpha = 1.0f;
    self.blurEffectView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);

    self.tableView.userInteractionEnabled = NO;
    [self.view addSubview:self.blurEffectView];
}

- (void)hideBlurEffect {
    assert(NSThread.isMainThread);

    if (UIAccessibilityIsReduceTransparencyEnabled()) {
        return;
    }

    [UIView animateWithDuration:0.55 animations:^{
        self.blurEffectView.alpha = 0.0f;
        self.blurEffectView.transform = CGAffineTransformMakeScale(0.25f, 0.25f);
    } completion:^(BOOL finished) {
        [self.blurEffectView removeFromSuperview];
        self.tableView.userInteractionEnabled = YES;
    }];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.output didSelectItemAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.dataSource tableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.output heightForRowAtIndexPath:indexPath];
}

@end

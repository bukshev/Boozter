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

}

- (void)showBlurEffect {

}
- (void)hideBlurEffect {

}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 0.0f;
}

@end

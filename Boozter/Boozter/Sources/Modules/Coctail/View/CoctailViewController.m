//
//  CoctailViewController.m
//  Boozter
//
//  Created by Ivan Bukshev on 05/09/2019.
//  Copyright © 2019 Team Absurdum. All rights reserved.
//

#import "CoctailViewController.h"
#import "ICoctailViewOutput.h"
#import "CoctailDetailsItem.h"

#import "UIColor+Application.h"
#import "UINavigationController+StatusBarColor.h"

@interface CoctailViewController ()
@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;
@property (nonatomic, weak) IBOutlet UIView *contentView;
@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *categoryLabel;
@property (nonatomic, weak) IBOutlet UILabel *alcoholicLabel;
@property (nonatomic, weak) IBOutlet UILabel *glassNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *measuredIngredientsLabel;
@property (nonatomic, weak) IBOutlet UILabel *instructionsLabel;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *favorBarButtonItem;
@property (weak, nonatomic) IBOutlet UIButton *favorButton;
@end

@implementation CoctailViewController

#pragma mark - Initialization

- (void)injectOutput:(id<ICoctailViewOutput>)output {
    assert(nil != output);
    _output = output;
}

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.output onViewReadyEvent];
}

#pragma mark - User Actions

- (IBAction)onFavorBarButtonItemTap:(UIBarButtonItem *)sender {
    [self.output onFavorEvent];
}

- (IBAction)onFavorButtonTap:(UIButton *)sender {
    [self.output onFavorEvent];
}

#pragma mark - ICoctailViewinput

- (void)setupInitialStateWithTitle:(NSString *)title {
    assert(nil != self.output);

    self.navigationItem.title = title;

    self.imageView.alpha = 0.0f;
    self.nameLabel.alpha = 0.0f;
    self.categoryLabel.alpha = 0.0f;
    self.alcoholicLabel.alpha = 0.0f;
    self.glassNameLabel.alpha = 0.0f;
    self.measuredIngredientsLabel.alpha = 0.0f;
    self.instructionsLabel.alpha = 0.0f;
    self.favorButton.alpha = 0.0f;

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

- (void)configureWithItem:(CoctailDetailsItem *)item {
    assert(nil != item);
    assert(NSThread.isMainThread);

    self.nameLabel.text = item.name;
    self.categoryLabel.text = item.category;
    self.alcoholicLabel.text = item.alcoholic;
    self.glassNameLabel.text = [NSString stringWithFormat:@"Glass: %@", item.glassName];
    self.measuredIngredientsLabel.text = item.measuredIngredientsText;
    self.instructionsLabel.text = [item.instructions stringByAppendingString:@"\n\n\n\n\n\n\n\naaaa\n\n\n\nend"];

    [UIView animateWithDuration:0.55f animations:^{
        self.imageView.alpha = 1.0f;
        self.nameLabel.alpha = 1.0f;
        self.categoryLabel.alpha = 1.0f;
        self.alcoholicLabel.alpha = 1.0f;
        self.glassNameLabel.alpha = 1.0f;
        self.measuredIngredientsLabel.alpha = 1.0f;
        self.instructionsLabel.alpha = 1.0f;
        self.favorButton.alpha = 1.0f;
    }];
}

- (void)updateImageWithData:(NSData *)imageData {
    assert(nil != imageData);
    assert(NSThread.isMainThread);

    if (nil == self.imageView.image) {
        self.imageView.image = [UIImage imageWithData:imageData];
    }
}

- (void)setFavoritedState {
    [self.favorButton setTitle:@"Remove from Favorited" forState:UIControlStateNormal];
    [self.favorBarButtonItem setImage:[UIImage systemImageNamed:@"star.fill"]];
}

- (void)discardFavoritedState {
    [self.favorButton setTitle:@"Add to Favorited" forState:UIControlStateNormal];
    [self.favorBarButtonItem setImage:[UIImage systemImageNamed:@"star"]];
}

@end

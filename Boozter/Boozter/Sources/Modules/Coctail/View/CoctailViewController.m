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

@interface CoctailViewController ()
@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;
@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *categoryLabel;
@property (nonatomic, weak) IBOutlet UILabel *alcoholicLabel;
@property (nonatomic, weak) IBOutlet UILabel *glassNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *measuredIngredientsLabel;
@property (nonatomic, weak) IBOutlet UILabel *instructionsLabel;
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

#pragma mark - ICoctailViewinput

- (void)setupInitialState {
    assert(nil != self.output);
}

- (void)configureWithItem:(CoctailDetailsItem *)item {
    assert(nil != item);
    assert(NSThread.isMainThread);

    self.navigationItem.title = item.name;

    self.nameLabel.text = item.name;
    self.categoryLabel.text = item.category;
    self.alcoholicLabel.text = item.alcoholic;
    self.glassNameLabel.text = [NSString stringWithFormat:@"Glass: %@", item.glassName];
    self.measuredIngredientsLabel.text = item.measuredIngredientsText;
    self.instructionsLabel.text = item.instructions;
}

- (void)updateImageWithData:(NSData *)imageData {
    assert(nil != imageData);
    assert(NSThread.isMainThread);

    if (nil == self.imageView.image) {
        self.imageView.image = [UIImage imageWithData:imageData];
    }
}

@end

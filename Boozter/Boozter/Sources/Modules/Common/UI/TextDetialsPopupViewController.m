//
//  TextDetialsPopupViewController.m
//  Boozter
//
//  Created by Букшев Иван Евгеньевич on 20.02.2021.
//  Copyright © 2021 Team Absurdum. All rights reserved.
//

#import "TextDetialsPopupViewController.h"

@interface TextDetialsPopupViewController ()
@property (nonatomic, weak) IBOutlet UILabel *textLabel;
@property (nonatomic, weak) IBOutlet UIButton *dismissButton;
@property (nonatomic, copy) NSString *detailsText;
@end

@implementation TextDetialsPopupViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupInitialState];
}

- (void)setText:(NSString *)text {
    assert(nil != text);
    
    self.detailsText = [text copy];
}

- (IBAction)onDismissButtonTap:(id)sender {

}

- (void)setupInitialState {
    self.textLabel.text = [self.detailsText copy];
}

@end

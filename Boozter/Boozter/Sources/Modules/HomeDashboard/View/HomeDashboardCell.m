//
//  HomeDashboardCell.m
//  Boozter
//
//  Created by Ivan Bukshev on 02/09/2019.
//  Copyright © 2019 Team Absurdum. All rights reserved.
//

#import "HomeDashboardCell.h"
#import "HomeDashboardItem.h"

@interface HomeDashboardCell ()
@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@end

@implementation HomeDashboardCell

#pragma mark - Public Interface

+ (NSString *)reuseIdentifier {
    return NSStringFromClass([self class]);
}

- (void)configureWithItem:(HomeDashboardItem *)item {
    assert(nil != item);
    
    self.nameLabel.text = item.coctailName;
    self.imageView.image = [UIImage imageWithData:item.coctailImageData];
}

- (void)configureImageWithData:(NSData *)imageData {
    self.imageView.image = [UIImage imageWithData:imageData];
}

@end

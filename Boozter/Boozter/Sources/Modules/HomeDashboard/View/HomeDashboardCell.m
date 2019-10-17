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
@property (nonatomic, weak) IBOutlet UILabel *namelabel;
@end

@implementation HomeDashboardCell

#pragma mark - Public Interface

- (void)configureWithItem:(HomeDashboardItem *)item {
    assert(nil != item);
    self.namelabel.text = item.coctailName;
//    [self loadImageWithURL:item.coctailImageURL];
}

+ (NSString *)reuseIdentifier {
    return NSStringFromClass([self class]);
}

#pragma mark - Private helpers

- (void)loadImageWithURL:(NSURL *)url {
    // TODO: Show activity indicator on image.
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        NSData *imageData = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:imageData];

        dispatch_sync(dispatch_get_main_queue(), ^{
            if (nil != image) {
                self.imageView.image = image;
            } else {
                self.imageView.image = [UIImage imageNamed:@"PlaceholderImage"];
            }

            // TODO: Hide activity indicator on image.
            // TODO: Stop activity indicator on image.

            [self setNeedsLayout];
        });
    });
}

@end

//
//  IHomeDashboardCellImageDownloader.h
//  Boozter
//
//  Created by Ivan Bukshev on 31/10/2019.
//  Copyright © 2019 Team Absurdum. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol IHomeDashboardCellImageDownloader <NSObject>

- (void)downloadImageFromURL:(NSURL *)url indexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END

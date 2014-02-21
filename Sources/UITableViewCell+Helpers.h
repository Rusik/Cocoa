//
//  UITableViewCell+Helpers.h
//
//  Created by Ruslan Kavetsky.
//  Copyright (c) 2013 Ruslan Kavetsky. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UITableViewCellHeight <NSObject>

@required
+ (CGFloat)cellHeight;

@end

@interface UITableViewCell (Helpers)

+ (NSString *)cellIdentifier;
+ (UINib *)nibForCell;

@end

//
//  UITableViewCell+Helpers.m
//
//  Created by Ruslan Kavetsky.
//  Copyright (c) 2013 Ruslan Kavetsky. All rights reserved.
//

#import "UITableViewCell+Helpers.h"

@implementation UITableViewCell (Helpers)

+ (NSString *)cellIdentifier {
	return NSStringFromClass(self);
}

+ (UINib *)nibForCell {
	return [UINib nibWithNibName:[self cellIdentifier] bundle:nil];
}

@end

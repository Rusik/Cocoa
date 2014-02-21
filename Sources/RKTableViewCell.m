//
//  RKTableViewCell.m
//
//  Created by Ruslan Kavetsky.
//  Copyright (c) 2012 Ruslan Kavetsky. All rights reserved.
//

#import "RKTableViewCell.h"

@implementation RKTableViewCell {
	NSMutableDictionary *viewToBackgroundColorMap;
}

- (void)saveBackgroundColors {
	
	if (!viewToBackgroundColorMap) {
		viewToBackgroundColorMap = [NSMutableDictionary dictionary];
	}
	
	NSMutableArray *queue = [NSMutableArray array];
	[queue addObjectsFromArray:self.subviews];
	
	while (queue.count) {
		
		UIView *view = [queue objectAtIndex:0];
		if (view.backgroundColor) {
			id key = [NSNumber numberWithInt:view.hash];
			[viewToBackgroundColorMap setObject:[view.backgroundColor copy] forKey:key];
		}
		
		[queue addObjectsFromArray:view.subviews];
		[queue removeObjectAtIndex:0];
	}
}

- (void)restoreBackgroundColors {
	
	NSMutableArray *queue = [NSMutableArray array];
	[queue addObjectsFromArray:self.subviews];
	
	while (queue.count) {
		
		UIView *view = [queue objectAtIndex:0];
		if (![view isKindOfClass:[UILabel class]]) {
			id key = [NSNumber numberWithInt:view.hash];
			view.backgroundColor = [viewToBackgroundColorMap objectForKey:key];
			[viewToBackgroundColorMap removeObjectForKey:view.description];
		}
		
		[queue addObjectsFromArray:view.subviews];
		[queue removeObjectAtIndex:0];
	}
	[viewToBackgroundColorMap removeAllObjects];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	if (!selected) {
		[super setHighlighted:selected animated:animated];
	} else {
		[self saveBackgroundColors];
		[super setHighlighted:selected animated:animated];
		[self restoreBackgroundColors];
	}
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
	if (!highlighted) {
		[super setHighlighted:highlighted animated:animated];
	} else {
		[self saveBackgroundColors];
		[super setHighlighted:highlighted animated:animated];
		[self restoreBackgroundColors];
	}
}

@end

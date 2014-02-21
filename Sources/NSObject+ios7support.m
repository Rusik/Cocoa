//
//  NSObject+ios7support.m
//  choicer
//
//  Created by Ruslan Kavetsky.
//  Copyright (c) 2013 Ruslan Kavetsky. All rights reserved.
//

#import "NSObject+ios7support.h"

@implementation NSObject (ios7support)

- (void)performForIos6Block:(void (^)())ios6Block ios7Block:(void (^)())ios7Block {
	[self.class performForIos6Block:ios6Block ios7Block:ios7Block];
}

+ (void)performForIos6Block:(void (^)())ios6Block ios7Block:(void (^)())ios7Block {

	NSString *version = [[UIDevice currentDevice] systemVersion];
	int ver = [version intValue];
	if (ver < 7) {
		//iOS 6 work
		if (ios6Block) {
			ios6Block();
		}
	} else {
		//iOS 7 related work
		if (ios7Block) {
			ios7Block();
		}
	}
}

@end

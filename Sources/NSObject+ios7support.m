//
//  NSObject+ios7support.m
//  choicer
//
//  Created by Ruslan Kavetsky.
//  Copyright (c) 2013 Ruslan Kavetsky. All rights reserved.
//

#import "NSObject+ios7support.h"

@implementation NSObject (ios7support)

- (void)performForIos6:(void (^)())ios6Block ios7:(void (^)())ios7Block {
	[self.class performForIos6:ios6Block ios7:ios7Block];
}

+ (void)performForIos6:(void (^)())ios6Block ios7:(void (^)())ios7Block {
	if ([[[UIDevice currentDevice] systemVersion] intValue] < 7) {
		if (ios6Block) ios6Block();
	} else {
		if (ios7Block) ios7Block();
	}
}

- (void)performForIos6:(void (^)())ios6Block {
    [self performForIos6:ios6Block ios7:nil];
}

+ (void)performForIos6:(void (^)())ios6Block {
    [self performForIos6:ios6Block ios7:nil];
}

- (void)performForIos7:(void (^)())ios7Block {
    [self performForIos6:nil ios7:ios7Block];
}

+ (void)performForIos7:(void (^)())ios7Block {
    [self performForIos6:nil ios7:ios7Block];
}

@end

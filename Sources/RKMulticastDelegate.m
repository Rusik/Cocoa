//
//  RKMulticastDelegate.m
//
//  Created by Ruslan Kavetsky.
//  Copyright (c) 2014 Ruslan Kavetsky. All rights reserved.
//

#import "RKMulticastDelegate.h"

@implementation RKMulticastDelegate {
	NSHashTable *_delegates;
}

- (id)init {
	if (self = [super init]) {
		_delegates = [NSHashTable weakObjectsHashTable];
	}
	return self;
}

- (void)addDelegate:(id)delegate {
	[_delegates addObject:delegate];
}

- (BOOL)respondsToSelector:(SEL)aSelector {
	if ([super respondsToSelector:aSelector])
		return YES;

	for (id delegate in _delegates) {
		if ([delegate respondsToSelector:aSelector]) {
			return YES;
		}
	}

	return NO;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
	for (id delegate in _delegates) {
		if ([delegate respondsToSelector:[anInvocation selector]]) {
			[anInvocation invokeWithTarget:delegate];
		}
	}
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
	NSMethodSignature *signature = [super methodSignatureForSelector:aSelector];

	if (!signature) {
		for (id delegate in _delegates) {
			if ([delegate respondsToSelector:aSelector]) {
				return [delegate methodSignatureForSelector:aSelector];
			}
		}
	}

	return signature;
}

@end

//
//  RKOnePixelView.m
//
//  Created by Ruslan Kavetsky.
//  Copyright (c) Ruslan Kavetsky. All rights reserved.
//

#import "RKOnePixelView.h"

#define IS_RETINA ([[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)] && ([UIScreen mainScreen].scale == 2.0))

@implementation OnePixelView {
    CGRect _initialFrame;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initilize];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initilize];
    }
    return self;
}

- (void)initilize {

    _initialFrame = self.frame;
    _horizontal = YES;

    [self update];
}

- (void)setHorizontal:(BOOL)horizontal {
    _horizontal = horizontal;
    [self update];
}

- (void)update {

    CGRect frame = _initialFrame;
    if (_horizontal) {
        if (IS_RETINA) {
            frame.size.height = 0.5;
            frame.origin.y += 0.5;
        } else {
            frame.size.height = 1;
        }
    } else {
        if (IS_RETINA) {
            frame.size.width = 0.5;
            frame.origin.x += 0.5;
        } else {
            frame.size.width = 1;
        }
    }
    self.frame = frame;
}

@end

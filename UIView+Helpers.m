//
//  UIView+Helpers.m
//  helpers
//
//  Created by Ruslan on 12/13/12.
//  Copyright (c) 2012 Ruslan. All rights reserved.
//


#import "UIView+Helpers.h"

@implementation UIView (Helpers)

#pragma mark - Nib

+ (NSString *)nibName {
    return NSStringFromClass([self class]);
}

+ (id)loadFromNib {
    return [self loadFromNibNamed:[self nibName]];
}

+ (id)loadFromNibNamed:(NSString *)nibName {
    Class cls = [self class];
    NSArray *objects = [[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil];
    for (id object in objects) {
        if ([object isKindOfClass:cls]) {
            return object;
        }
    }
    [NSException raise:@"WrongNibFormat" format:@"Nib for '%@' must contain one UIView, and its class must be '%@'", nibName, NSStringFromClass(cls)];
    return nil;
}

#pragma mark - Frame

- (void)adjustFrame:(UIViewFrameAdjustBlock)block {
    self.frame = block(self.frame);
}

- (void)moveBy:(CGPoint)offset {
    [self adjustFrame:^CGRect (CGRect frame) {
        frame.origin.x += offset.x;
        frame.origin.y += offset.y;
        return frame;
    }];
}

- (void)moveTo:(CGPoint)origin {
    [self adjustFrame:^CGRect (CGRect frame) {
        frame.origin = origin;
        return frame;
    }];
}

- (void)resizeTo:(CGSize)size {
    [self adjustFrame:^CGRect (CGRect frame) {
        frame.size = size;
        return frame;
    }];
}

- (void)expand:(CGSize)size {
    [self adjustFrame:^CGRect (CGRect frame) {
        frame.size.width += size.width;
        frame.size.height += size.height;
        return frame;
    }];
}

#pragma mark - Rotation

- (void)rotateViewToOrientation:(UIInterfaceOrientation)orientation animated:(BOOL)animated {
    CGPoint center = self.center;
    CGRect bounds = self.bounds;
    CGAffineTransform transform = CGAffineTransformIdentity;
    switch (orientation) {
        case UIInterfaceOrientationPortrait:
            transform = CGAffineTransformIdentity;
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
            transform = CGAffineTransformMakeRotation(M_PI);
            break;
        case UIInterfaceOrientationLandscapeLeft:
            transform = CGAffineTransformMakeRotation(-M_PI_2);
            break;
        case UIInterfaceOrientationLandscapeRight:
            transform = CGAffineTransformMakeRotation(M_PI_2);
            break;
    }
    if (animated) {
        [UIView beginAnimations:nil context:nil];
    }
    self.transform = transform;
    bounds = CGRectApplyAffineTransform(bounds, transform);
    self.bounds = CGRectMake(0, 0, bounds.size.width, bounds.size.height);
    self.center = center;
    if (animated) {
        [UIView commitAnimations];
    }
}

#pragma mark - Other

- (void)recursiveEnumerateSubviewsUsingBlock:(void (^)(UIView *view, BOOL *stop))block {
    if (self.subviews.count == 0) {
        return;
    }
    for (UIView *subview in self.subviews) {
        BOOL stop = NO;
        block(subview, &stop);
        if (stop) {
            return;
        }
        [subview recursiveEnumerateSubviewsUsingBlock:block];
    }
}

@end
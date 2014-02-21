//
//  UIView+Helpers.h
//
//  Created by Ruslan Kavetsky.
//  Copyright (c) 2012 Ruslan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef CGRect (^UIViewFrameAdjustBlock)(CGRect frame);

@interface UIView (Helpers)

//Nib
+ (NSString *)nibName;
+ (id)loadFromNib;
+ (id)loadFromNibNamed:(NSString *)nibName;

//Frame
- (void)adjustFrame:(UIViewFrameAdjustBlock)block;
- (void)moveBy:(CGPoint)offset;
- (void)moveTo:(CGPoint)origin;
- (void)resizeTo:(CGSize)size;
- (void)expand:(CGSize)size;

@property (nonatomic, assign) CGPoint $origin;
@property (nonatomic, assign) CGSize $size;
@property (nonatomic, assign) CGFloat $x, $y, $width, $height;      // normal rect properties
@property (nonatomic, assign) CGFloat $left, $top, $right, $bottom; // these will stretch/shrink the rect


//Rotation
- (void)rotateViewToOrientation:(UIInterfaceOrientation)orientation animated:(BOOL)animated;

- (void)runSpinAnimationWithDuration:(CGFloat)duration
                           rotations:(CGFloat)rotations
                              repeat:(float)repeat;

//Other
- (void)recursiveEnumerateSubviewsUsingBlock:(void (^)(UIView *view, BOOL *stop))block;
- (UIView *)findFirstResponder;

@end

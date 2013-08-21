//
//  RKRoundedImageView.m
//  round
//
//  Created by Ruslan Kavetsky on 2/24/13.
//  Copyright (c) 2013 Ruslan Kavetsky. All rights reserved.
//

#import "RKRoundedImageView.h"

@implementation UIImage (RoundedCorners)

- (UIImage *)imageWithSize:(CGSize)size cornerRadius:(CGFloat)radius {
    UIImage *newImage;

    float width = 0;
    float height = 0;
    float ratio = self.size.width / self.size.height;
    height = size.height;
    width = height * ratio;
    if (width < size.width) {
        width = size.width;
        height = width / ratio;
    }

    CGRect imageRect = CGRectMake(0, 0, width, height);
    UIGraphicsBeginImageContextWithOptions(imageRect.size, NO, [[UIScreen mainScreen] scale]);

    CGRect roundedRect = CGRectMake((width - size.width) / 2, (height - size.height) / 2, size.width, size.height);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:roundedRect cornerRadius:radius];
    [path addClip];
    [self drawInRect:imageRect];

    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end

#define DEFAULT_CORNER_RADIUS 0.0

@implementation RKRoundedImageView {
    UIImage *_originalImage;
}

#pragma mark - Init

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
    _cornerRadius = DEFAULT_CORNER_RADIUS;
    self.contentMode = UIViewContentModeScaleAspectFill;
}

#pragma mark - Properties

- (void)setCornerRadius:(CGFloat)cornerRadius {
    _cornerRadius = cornerRadius;
    [self setImage:_originalImage];
}

#pragma - Overrides

- (void)setImage:(UIImage *)image {
    _originalImage = image;
    [super setImage:[image imageWithSize:self.bounds.size cornerRadius:_cornerRadius]];
}

- (UIImage *)image {
    return _originalImage;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self setImage:_originalImage];
}

- (void)setBounds:(CGRect)bounds {
    [super setBounds:bounds];
    [self setImage:_originalImage];
}

@end

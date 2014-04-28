//
//  RKDescriptionView.m
//  description
//
//  Created by Ruslan Kavetsky.
//  Copyright (c) Ruslan Kavetsky. All rights reserved.
//

#import "RKDescriptionView.h"
#import "UIView+Helpers.h"

@implementation RKDescriptionView {
    UILabel *_keyLabel;
    UILabel *_valueLabel;
    UILabel *_pointsLabel1;
}

- (instancetype)initWithProperty:(NSDictionary *)property forWidth:(CGFloat)width {
    self = [super init];
    if (self) {

        _keyLabel = [self label];
        _keyLabel.text = [[property allKeys] lastObject];        
        _valueLabel = [self label];
        _valueLabel.text = [[property allValues] lastObject];
        _pointsLabel1 = [self label];

        NSMutableString *string = [NSMutableString string];
        for (int i = 0; i < 100; i++) {
            [string appendString:@"."];
        }
        _pointsLabel1.text = string;

        [self addSubview:_valueLabel];
        [self addSubview:_pointsLabel1];
        [self addSubview:_keyLabel];

        [self layoutForWidth:width];
    }
    return self;
}

- (void)layoutForWidth:(CGFloat)width {
    CGSize keySize = [_keyLabel.text sizeWithFont:_keyLabel.font forWidth:width lineBreakMode:_keyLabel.lineBreakMode];
    CGSize valueSize = [_valueLabel.text sizeWithFont:_valueLabel.font forWidth:width lineBreakMode:_valueLabel.lineBreakMode];

    [_keyLabel sizeToFit];
    [_valueLabel sizeToFit];
    [_pointsLabel1 sizeToFit];

    CGFloat pointsMinWidth = 20.0;
    CGFloat space = 1.0;

    CGFloat pointsWidth = space * 2 + pointsMinWidth;
    CGFloat halfWidth = floorf((width - pointsWidth) / 2);

    _keyLabel.$origin = CGPointMake(0, 0);
    
    if (keySize.width + valueSize.width + pointsWidth > width) {

        if (keySize.width < halfWidth) {
            _keyLabel.$size = keySize;
            _valueLabel.$size = [_valueLabel.text sizeWithFont:_valueLabel.font
                                             constrainedToSize:CGSizeMake(width - keySize.width - pointsWidth, MAXFLOAT)
                                                 lineBreakMode:_valueLabel.lineBreakMode];
        } else if (valueSize.width < halfWidth) {
            _keyLabel.$size = [_keyLabel.text sizeWithFont:_keyLabel.font
                                         constrainedToSize:CGSizeMake(width - valueSize.width - pointsWidth, MAXFLOAT)
                                             lineBreakMode:_keyLabel.lineBreakMode];
            _valueLabel.$size = valueSize;
        } else {
            _keyLabel.$size = [_keyLabel.text sizeWithFont:_keyLabel.font
                                         constrainedToSize:CGSizeMake(halfWidth, MAXFLOAT)
                                             lineBreakMode:_keyLabel.lineBreakMode];
            _valueLabel.$size = [_valueLabel.text sizeWithFont:_valueLabel.font
                                             constrainedToSize:CGSizeMake(halfWidth, MAXFLOAT)
                                                 lineBreakMode:_valueLabel.lineBreakMode];
        }
    } else {
        _keyLabel.$size = keySize;
        _valueLabel.$size = valueSize;
    }

    _valueLabel.$origin = CGPointMake(width - _valueLabel.$width, 0);
    _pointsLabel1.$left = _keyLabel.$right + space;
    _pointsLabel1.$right = _valueLabel.$left - space;
    self.frame = CGRectMake(self.$x, self.$y, width, MAX(_keyLabel.$height, _valueLabel.$height));
}
- (UILabel *)label {
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    UIColor *fontColor = [UIColor blackColor];
    UILabel *label = [[UILabel alloc] init];
    label = [[UILabel alloc] init]; 
    label.font = font;
    label.backgroundColor = [UIColor clearColor];
    label.textColor = fontColor;
    label.numberOfLines = 0;
    
    return label;
}

@end

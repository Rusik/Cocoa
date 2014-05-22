//
//  UILabel+Adjust.m
//  ITMOSchedule
//
//  Created by Ruslan Kavetsky on 10/21/13.
//  Copyright (c) 2013 Ruslan Kavetsky. All rights reserved.
//

#import "UILabel+Adjust.h"
#import "UIView+Helpers.h"

@implementation UILabel (Adjust)

- (void)adjustSizeWithMaximumWidth:(CGFloat)minWidth {
    [self adjustSizeWithMaximumWidth:minWidth withFont:self.font];
}

- (void)adjustSizeWithMaximumWidth:(CGFloat)minWidth withFont:(UIFont *)font {

    self.font = font;

    CGRect rect;
    rect = [self.text boundingRectWithSize:CGSizeMake(minWidth, MAXFLOAT)
                                   options:NSLineBreakByWordWrapping | NSStringDrawingUsesLineFragmentOrigin
                                attributes:@{NSFontAttributeName: self.font}
                                   context:0];

    self.$size = rect.size;
    CGPoint origin = self.$origin;
    self.frame = CGRectIntegral(self.frame);
    self.$origin = origin;
}

- (void)adjustSizeForAttributedStringWithMaximumWidth:(CGFloat)minWidth {
    CGRect rect;
    rect = [self.attributedText boundingRectWithSize:CGSizeMake(minWidth, MAXFLOAT)
                                             options:NSLineBreakByWordWrapping | NSStringDrawingUsesLineFragmentOrigin
                                             context:0];

    self.$size = rect.size;
    CGPoint origin = self.$origin;
    self.frame = CGRectIntegral(self.frame);
    self.$origin = origin;
}

- (void)removeWhitespacesInLines {
    NSString *text;
    float height = 0;

    NSMutableArray *lines = [NSMutableArray new];
    NSMutableString *currentLine = [NSMutableString new];
    NSMutableString *currentWord = [NSMutableString new];

    for (int i = 0; i < self.text.length; i++) {

        text = [self.text substringToIndex:i + 1];

        NSString *c = [self.text substringWithRange:NSMakeRange(i, 1)];

        if ([c rangeOfCharacterFromSet:[NSCharacterSet whitespaceCharacterSet]].location == NSNotFound) {
            [currentWord appendString:c];
        } else {
            [currentLine appendString:currentWord];
            currentWord = [NSMutableString new];
            [currentLine appendString:c];
        }

        CGRect rect = [text boundingRectWithSize:CGSizeMake(self.$width, MAXFLOAT)
                                         options:NSLineBreakByWordWrapping | NSStringDrawingUsesLineFragmentOrigin
                                      attributes:@{NSFontAttributeName: self.font}
                                         context:0];

        if (height < rect.size.height) {
            if (height != 0) {
                [lines addObject:[currentLine copy]];
                currentLine = [NSMutableString new];
            }
        }
        height = rect.size.height;
    }
    [currentLine appendString:currentWord];
    [lines addObject:[currentLine copy]];

    NSMutableString *newText = [NSMutableString new];
    for (NSString *line in lines) {
        NSString *trimLine = [line stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        [newText appendFormat:@"%@\n", trimLine];
    }
    [newText deleteCharactersInRange:NSMakeRange(newText.length - 1, 1)];
    
    self.text = newText;
}

@end

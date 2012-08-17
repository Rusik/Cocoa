//
//  RKMovingLabel.h
//
//  Created by Ruslan Kavetsky
//  Copyright (c) 2012 Ruslan Kavetsky. All rights reserved.
//

#import "RKMovingLabel.h"
#import <QuartzCore/QuartzCore.h>

#define DEFAULT_SEPARATOR_WIDTH 50.0
#define DEFAULT_FONT_SIZE 18.0
#define SECONDS_PER_PIXEL 0.05
#define DEFAULT_STOP_TIME_INTERVAL 1.0
#define DEFAULT_FADE_LENGTH 10.0

@interface RKMovingLabel ()

- (void)customizeLabel:(UILabel *)label;
- (void)updateGradient;
- (void)updateLabelsFrame;
- (void)updateLabels;
- (void)configure;

- (UIColor *)defaultTextColor;

- (void)startAnimation;
- (void)stopAnimation;

@end

@implementation RKMovingLabel {
	UILabel *label1;
	UILabel *label2;
}

@synthesize text, separatorWidth, font, textColor, stopTimeInterval, fadeLength;

- (void)startAnimation {
	
	CGRect label1rect = label1.frame;
	CGRect label2rect = label2.frame;
	
	float font_size_coefficient = 10.0;
	
	[UIView animateWithDuration:label1.frame.size.width * SECONDS_PER_PIXEL / (self.font.pointSize / font_size_coefficient)
						  delay:self.stopTimeInterval 
						options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction
					 animations:^{
		
		CGFloat widthToMove = label1.frame.size.width + self.separatorWidth;
		
		CGRect rect = label1.frame;
		rect.origin.x -= widthToMove;
		label1.frame = rect;
		
		rect = label2.frame;
		rect.origin.x -= widthToMove;
		label2.frame = rect;
		
	} completion:^(BOOL finished){
		if (finished) {
			label1.frame = label1rect;
			label2.frame = label2rect;
			[self startAnimation];
		}
	}];
}

- (void)stopAnimation {
	[label1.layer removeAllAnimations];
	[label2.layer removeAllAnimations];
}

#pragma mark Private

- (void)updateLabels {
	[self customizeLabel:label1];
	[self customizeLabel:label2];
}

- (void)customizeLabel:(UILabel *)label {
	label.font = self.font;
	label.backgroundColor = [UIColor clearColor];
	label.textColor = self.textColor;
}

- (void)updateLabelsFrame {
	
	[label1 sizeToFit];
	if (label1.frame.size.width < self.frame.size.width) {
		label2.hidden = YES;
		
		CGRect rect = label1.frame;
		rect.size.height = self.bounds.size.height;
		rect.origin.y = 0;
		rect.origin.x = floorf((self.bounds.size.width - label1.frame.size.width) / 2);
		label1.frame = rect;
		
		[self stopAnimation];
	} else {
		[label2 sizeToFit];
		label2.hidden = NO;
		
		CGRect rect = label1.frame;
		rect.size.height = self.bounds.size.height;
		rect.origin.y = 0;
		rect.origin.x = fadeLength;
		label1.frame = rect;	
		
		rect = label2.frame;
		rect.size.height = self.bounds.size.height;
		rect.origin.y = 0;
		rect.origin.x = label1.frame.origin.x + label1.frame.size.width + self.separatorWidth;
		label2.frame = rect;
		
		[self startAnimation];
	}	
}

- (UIColor *)defaultTextColor {
	return [UIColor blackColor];
}

- (void)configure {
	label1 = [[UILabel alloc] initWithFrame:self.bounds];
	label2 = [[UILabel alloc] initWithFrame:self.bounds];
	[self addSubview:label1];
	[self addSubview:label2];
	
	self.clipsToBounds = YES;
	
	separatorWidth = DEFAULT_SEPARATOR_WIDTH;
	font = [[UIFont systemFontOfSize:DEFAULT_FONT_SIZE] retain];
	textColor = [[self defaultTextColor] retain];
	stopTimeInterval = DEFAULT_STOP_TIME_INTERVAL;
	fadeLength = DEFAULT_FADE_LENGTH;
	
	[self updateGradient];
	[self updateLabels];
}

- (void)updateGradient {
	
	CAGradientLayer *gradient = [CAGradientLayer layer];
	gradient.frame = self.bounds;
	gradient.startPoint = CGPointMake(0.0, 0.5);
	gradient.endPoint = CGPointMake(1.0, 0.5);
	
	float fade_point = fadeLength / self.bounds.size.width;
	
	gradient.locations = [NSArray arrayWithObjects:
						  [NSNumber numberWithFloat: 0.0],
						  [NSNumber numberWithFloat: fade_point],
						  [NSNumber numberWithFloat: 1.0 - fade_point],
						  [NSNumber numberWithFloat: 1.0],
						  nil];
	
	float transparent = 0.0;
	float opaque = 1.0;
	
	UIColor *color1 = [UIColor colorWithWhite:1.0 alpha:transparent];
	UIColor *color2 = [UIColor colorWithWhite:1.0 alpha:opaque];
	UIColor *color3 = [UIColor colorWithWhite:1.0 alpha:opaque];
	UIColor *color4 = [UIColor colorWithWhite:1.0 alpha:transparent];
	
	gradient.colors = [NSArray arrayWithObjects:(id)color1.CGColor, (id)color2.CGColor, (id)color3.CGColor, (id)color4.CGColor, nil];
	self.layer.mask = gradient;	
}

#pragma mark Property

- (void)setText:(NSString *)aText {
	label1.text = aText;
	label2.text = aText;
	
	[self updateLabelsFrame];
}

- (NSString *)text {
	return label1.text;
}

- (void)setFont:(UIFont *)aFont {
	if (aFont == font) {
		return;
	}
	[font release];
	font = [aFont retain];
	
	[self updateLabels];
	[self updateLabelsFrame];
}

- (void)setSeparatorWidth:(CGFloat)aSeparatorWidth {
	if (separatorWidth == aSeparatorWidth) {
		return;
	}
	separatorWidth = aSeparatorWidth;
	[self updateLabelsFrame];
}

- (void)setTextColor:(UIColor *)aTextColor {
	if (textColor == aTextColor) {
		return;
	}
	[textColor release];
	textColor = [aTextColor retain];
	
	[self updateLabels];
}

- (void)setFadeLength:(float)aFadeLength {
	if (fadeLength == aFadeLength) {
		return;
	}
	fadeLength = aFadeLength;
	
	[self updateGradient];
	[self updateLabelsFrame];
}

#pragma mark - Memory

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		[self configure];
	}
	return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	self = [super initWithCoder:aDecoder];
	if (self) {
		[self configure];
	}
	return self;
}

- (void)dealloc {
	[label1 release];
	[label2 release];
	[font release];
	[textColor release];
	[super dealloc];
}
@end

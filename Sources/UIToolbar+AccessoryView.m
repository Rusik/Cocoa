//
//  UIToolbar+AccessoryView.m
//
//  Created by Ruslan Kavetsky.
//  Copyright (c) 2013 Ruslan Kavetsky. All rights reserved.
//

#import "UIToolbar+AccessoryView.h"
#import "NSObject+ios7support.h"

@interface ButtonsSegmentedControl : UISegmentedControl

@property (nonatomic, weak) id target;
@property (nonatomic) SEL forwardAction;
@property (nonatomic) SEL backwardAction;

@end

@implementation ButtonsSegmentedControl

- (id)init {
	self = [super initWithItems:@[NSLocalizedString(@"Previous", nil), NSLocalizedString(@"Next", nil)]];
	if (self) {
		self.segmentedControlStyle = UISegmentedControlStyleBar;
		self.momentary = YES;
		[self addTarget:self action:@selector(didPress) forControlEvents:UIControlEventValueChanged];
	}
	return self;
}

- (void)didPress {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
	if (self.selectedSegmentIndex == 0) {
		[_target performSelector:_backwardAction];
	} else {
		[_target performSelector:_forwardAction];
	}
#pragma clang diagnostic pop
}

@end

typedef NS_ENUM (NSInteger, ArrowButtonType) {
	ArrowButtonTypeLeft,
	ArrowButtonTypeRight
};

@interface ArrowButton : UIBarButtonItem

@end

static NSString * leftArrowImageData = @"iVBORw0KGgoAAAANSUhEUgAAABoAAAAsCAYAAAB7aah+AAAACXBIWXMAABYlAAAWJQFJUiTwAAAAHGlET1QAAAACAAAAAAAAABYAAAAoAAAAFgAAABYAAACkaqmnSAAAAHBJREFUWAliYKAN0KaNsaimhgO5f4C4HlWYujyYJf+BxoIwTSxDtwRkEchnOkBMNYDLEpA41cCoJSQF5WhwjQYXuFiB5fjRzIg1QQyffJIO9B+oaAdFOAyD+FSN+AYkw4e2JaAaED24QD6aDMRUAwAAAAD//7aUeycAAABPSURBVGNggIBwIPUHiP8jYRA/DIipDkYto0qQjgbjaDDiDQFcCQQkTnUwahlVgnQ0GIdPMOpQxStohqAnkHo0eapyYZbR1BKYi7VhDLrTAM2E3Eds1mG7AAAAAElFTkSuQmCC";

static NSString *rightArrowImageData = @"iVBORw0KGgoAAAANSUhEUgAAABoAAAAsCAYAAAB7aah+AAAACXBIWXMAABYlAAAWJQFJUiTwAAAAHGlET1QAAAACAAAAAAAAABYAAAAoAAAAFgAAABYAAACFJsC3FgAAAFFJREFUWAliYBhAoE0Pu+uBlvwB4nBaWgay5D8U08wyHaAFIMNhFoFomlkGCq5Ry4CBQBkYDUbKwg+qe/gGYxjQh3TLZ6OWUSU1jgbjMAtGAAAAAP//JBya5wAAAG1JREFUY2CgLpgMNO4/Gv4D5OtQ05pwoGEgQ9EtahgWloB8lk5rn4AsAQUj1QC2OBm1BGfwjgYXzqDBJjEaXNhCBafYaHDhDBpsEnQJLlANiF5pUb2AhPmuHsiA1Y40swTZMppbArNMG8agJg0A6cbcRxxTfzoAAAAASUVORK5CYII=";

@implementation ArrowButton

- (instancetype)initWithType:(ArrowButtonType)type target:(id)target action:(SEL)action width:(float)width {
	self = [super init];
	if (self) {

		UIImage *leftArrowImage = [UIImage imageWithData:[[NSData alloc] initWithBase64EncodedString:leftArrowImageData
		                                                                                     options:0]];
		UIImage *rightArrowImage = [UIImage imageWithData:[[NSData alloc] initWithBase64EncodedString:rightArrowImageData
		                                                                                      options:0]];
		UIImage *left = [UIImage imageWithCGImage:leftArrowImage.CGImage
		                                    scale:2.0
		                              orientation:leftArrowImage.imageOrientation];
		UIImage *right = [UIImage imageWithCGImage:rightArrowImage.CGImage
		                                     scale:2.0
		                               orientation:rightArrowImage.imageOrientation];

		if (type == ArrowButtonTypeLeft) {
			self.image = left;
		} else {
			self.image = right;
		}
		self.target = target;
		self.action = action;
		self.width = width;
	}
	return self;
}

@end


@implementation UIToolbar (AccessoryView)

+ (UIToolbar *)accessoryViewWithDoneButtonWithTarget:(id)target
                                              action:(SEL)action {

	UIToolbar *toolBar = [[UIToolbar alloc] init];

	UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
	                                                                        target:target
	                                                                        action:action];

	UIBarButtonItem *flexibleSpace = [self flexibleSpace];

	toolBar.items = @[flexibleSpace, button];
	[toolBar sizeToFit];

	return toolBar;
}

+ (UIToolbar *)accessoryViewWithButtonWithTitle:(NSString *)title
                                         target:(id)target
                                         action:(SEL)action {

	UIToolbar *toolBar = [[UIToolbar alloc] init];

	UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain
	                                                          target:target
	                                                          action:action];

	UIBarButtonItem *flexibleSpace = [self flexibleSpace];

	toolBar.items = @[flexibleSpace, button];
	[toolBar sizeToFit];

	return toolBar;
}

+ (UIToolbar *)toolbarWithSwitchAndDoneButtonsbyTarget:(id)target
                                   actionForSwitchBack:(SEL)switchActionBack
                                actionForSwitchForward:(SEL)switchActionForward
                                            doneAction:(SEL)doneActionSel {

	UIToolbar *toolBar = [[UIToolbar alloc] init];

	[self performForIos6:^{

	    ButtonsSegmentedControl *segmentedControl = [[ButtonsSegmentedControl alloc] init];
	    segmentedControl.target = target;
	    segmentedControl.backwardAction = switchActionBack;
	    segmentedControl.forwardAction = switchActionForward;

	    UIBarButtonItem *segmentItem = [[UIBarButtonItem alloc] initWithCustomView:segmentedControl];

	    UIBarButtonItem *flexibleSpace = [self flexibleSpace];

	    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
	                                                                          target:target
	                                                                          action:doneActionSel];

	    toolBar.items = @[segmentItem, flexibleSpace, done];
	} ios7:^{

	    ArrowButton *arrowLeft = [[ArrowButton alloc] initWithType:ArrowButtonTypeLeft
	                                                        target:target
	                                                        action:switchActionBack
	                                                         width:0];
	    ArrowButton *arrowRight = [[ArrowButton alloc] initWithType:ArrowButtonTypeRight
	                                                         target:target
	                                                         action:switchActionForward
	                                                          width:20];

	    UIBarButtonItem *flexibleSpace = [self flexibleSpace];


	    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
	                                                                          target:target
	                                                                          action:doneActionSel];

	    UIBarButtonItem *fixedSpace = [self fixedSpaceWithWidth:20];

	    toolBar.items = @[arrowLeft, fixedSpace, arrowRight, flexibleSpace, done];
	}];

	[toolBar sizeToFit];

	return toolBar;
}

+ (UIBarButtonItem *)fixedSpaceWithWidth:(float)width {
	UIBarButtonItem *item = [UIBarButtonItem new];
	item.style = UIBarButtonSystemItemFixedSpace;
	item.width = width;
	return item;
}

+ (UIBarButtonItem *)flexibleSpace {
	return [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
}

@end

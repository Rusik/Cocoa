//
//  RKAlertViewController.m
//
//  Created by Ruslan Kavetsky.
//  Copyright (c) 2013 Ruslan Kavetsky. All rights reserved.
//

#import "RKAlertViewController.h"

#define ANIMATION_DURATION 0.3

NSString *AlertHideNotification = @"RKAlertHideNotification";
NSString *AlertShowNotification = @"RKAlertShowNotification";

@implementation RKAlertViewController {
	BOOL alertIsHidden;
    UIWindow *_alertWindow;
	UIWindow *_mainWindow;
}

- (id)init {
	self = [super init];
	if (self) {
		[self subscribe];
	}
	return self;
}

- (void)awakeFromNib {
	[super awakeFromNib];
	[self subscribe];
}

- (void)dealloc {
	[self unsubscribe];
}

- (void)showAlert {
	[self showAlertAtLevel:UIWindowLevelAlert];
}

- (void)showAlertAtLevel:(UIWindowLevel)windowLevel {
	_displaying = YES;

	_mainWindow = [UIApplication sharedApplication].keyWindow;

	_alertWindow = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	_alertWindow.windowLevel = windowLevel;
	_alertWindow.backgroundColor = [UIColor clearColor];
	_alertWindow.rootViewController = self;
	[_alertWindow makeKeyAndVisible];
	[self updateOrientation];

	self.view.alpha = 0;

	[UIView animateWithDuration:ANIMATION_DURATION animations:^{
	    [self willAnimateAppear];
	    self.view.alpha = 1;
	}];
}

- (void)close {
	[UIView animateWithDuration:ANIMATION_DURATION animations:^{
	    [self willAnimateDisappear];
	    self.view.alpha = 0;
	} completion:^(BOOL completed) {
	    [self.view removeFromSuperview];
	    _alertWindow = nil;
	    _displaying = NO;

	    if ([_alertDelegate respondsToSelector:@selector(alertDidClose:)]) {
	        [_alertDelegate alertDidClose:self];
		}
	}];

	if ([_alertDelegate respondsToSelector:@selector(alertWillClose:)]) {
		[_alertDelegate alertWillClose:self];
	}
}

#pragma mark - Notifications

- (void)subscribe {
	[[NSNotificationCenter defaultCenter] addObserver:self
	                                         selector:@selector(notificationHide:)
	                                             name:AlertHideNotification
	                                           object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self
	                                         selector:@selector(notificationShow:)
	                                             name:AlertShowNotification
	                                           object:nil];

	[[NSNotificationCenter defaultCenter] addObserver:self
	                                         selector:@selector(updateOrientation)
	                                             name:UIApplicationDidChangeStatusBarOrientationNotification
	                                           object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self
	                                         selector:@selector(updateOrientation)
	                                             name:UIApplicationDidChangeStatusBarFrameNotification
	                                           object:nil];
}

- (void)unsubscribe {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Rotation

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

- (BOOL)shouldAutorotate {
	return NO;
}

#define DegreesToRadians(degrees) (degrees * M_PI / 180)

- (CGAffineTransform)transformForOrientation:(UIInterfaceOrientation)orientation {

	switch (orientation) {
		case UIInterfaceOrientationLandscapeLeft:
			return CGAffineTransformMakeRotation(-DegreesToRadians(90));

		case UIInterfaceOrientationLandscapeRight:
			return CGAffineTransformMakeRotation(DegreesToRadians(90));

		case UIInterfaceOrientationPortraitUpsideDown:
			return CGAffineTransformMakeRotation(DegreesToRadians(180));

		case UIInterfaceOrientationPortrait:
		default:
			return CGAffineTransformMakeRotation(DegreesToRadians(0));
	}
}

- (void)updateOrientation {
	UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
	[_alertWindow setTransform:[self transformForOrientation:orientation]];
	_alertWindow.frame = _mainWindow.frame;
}

#pragma mark - Subclassing

- (void)willAnimateAppear {
}

- (void)willAnimateDisappear {
}

#pragma mark Appearance

- (void)notificationShow:(id)notificationShow {
	[self setAlertHidden:NO animated:YES];
}

- (void)notificationHide:(id)notificationHide {
	[self setAlertHidden:YES animated:YES];
}

- (void)setAlertHidden:(BOOL)hidden animated:(BOOL)animated {
	if (alertIsHidden == hidden) {
		return;
	}

	alertIsHidden = hidden;

    _alertWindow.userInteractionEnabled = !hidden;

	CGSize viewSize = self.view.frame.size;
	CGRect targetFrame = hidden ? CGRectMake(viewSize.width, 0, viewSize.width, viewSize.height) : CGRectMake(0, 0, viewSize.width, viewSize.height);
	CGFloat targetAlpha = hidden ? 0 : 1;

	if (animated) {
		__weak RKAlertViewController *weakSelf = self;
		[UIView animateWithDuration:ANIMATION_DURATION
		                      delay:0
		                    options:UIViewAnimationOptionBeginFromCurrentState
		                 animations:^{
                             weakSelf.view.frame = targetFrame;
                             weakSelf.view.alpha = targetAlpha;
                         } completion:nil];
	} else {
		self.view.frame = targetFrame;
		self.view.alpha = targetAlpha;
	}
}

#pragma mark All alerts appearance

+ (void)hideAllAlerts {
	[[NSNotificationCenter defaultCenter] postNotificationName:AlertHideNotification object:nil];
}

+ (void)showAllAlerts {
	[[NSNotificationCenter defaultCenter] postNotificationName:AlertShowNotification object:nil];
}

@end

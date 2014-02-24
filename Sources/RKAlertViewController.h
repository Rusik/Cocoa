//
//  RKAlertViewController.h
//
//  Created by Ruslan Kavetsky.
//  Copyright (c) 2013 Ruslan Kavetsky. All rights reserved.
//

@protocol RKAlertViewControllerDelegate;

@interface RKAlertViewController : UIViewController

@property(weak, nonatomic) id<RKAlertViewControllerDelegate> alertDelegate;
@property(nonatomic, readonly) BOOL displaying;

- (void)showAlert;
- (void)showAlertAtLevel:(UIWindowLevel)windowLevel;
- (void)close;

- (void)setAlertHidden:(BOOL)hidden animated:(BOOL)animated;

+ (void)showAllAlerts;
+ (void)hideAllAlerts;

- (void)willAnimateAppear;
- (void)willAnimateDisappear;

@end

@protocol RKAlertViewControllerDelegate <NSObject>

@optional
- (void)alertWillClose:(RKAlertViewController *)alert;
- (void)alertDidClose:(RKAlertViewController *)alert;

@end

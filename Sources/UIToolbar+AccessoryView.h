//
//  UIToolbar+AccessoryView.h
//
//  Created by Ruslan Kavetsky.
//  Copyright (c) 2013 Ruslan Kavetsky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIToolbar (AccessoryView)

+ (UIToolbar *)accessoryViewWithDoneButtonWithTarget:(id)target
                                              action:(SEL)action;

+ (UIToolbar *)accessoryViewWithButtonWithTitle:(NSString *)title
                                         target:(id)target
                                         action:(SEL)action;

+ (UIToolbar *)toolbarWithSwitchAndDoneButtonsbyTarget:(id)target
                                   actionForSwitchBack:(SEL)switchActionBack
                                actionForSwitchForward:(SEL)switchActionForward
                                            doneAction:(SEL)doneActionSel;

@end

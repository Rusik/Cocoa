//
//  RKMovingLabel.h
//
//  Created by Ruslan Kavetsky
//  Copyright (c) 2012 Ruslan Kavetsky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RKMovingLabel : UIView

@property (nonatomic, copy) NSString *text;
@property (nonatomic, retain) UIFont *font;
@property (nonatomic, retain) UIColor *textColor;
@property (nonatomic, assign) CGFloat separatorWidth;
@property (nonatomic, assign) CGFloat stopTimeInterval;
@property (nonatomic, assign) float fadeLength;

@end

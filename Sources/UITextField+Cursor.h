//
//  UITextField+Cursor.h
//  choicer
//
//  Created by Ruslan Kavetsky on 16.09.13
//  Copyright (c) 2013 Ruslan Kavetsky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Cursor)

- (void)moveCursorToPosition:(NSInteger)position;
- (NSInteger)cursorPosition;

@end

//
//  UITextField+Cursor.h
//
//  Created by Ruslan Kavetsky.
//  Copyright (c) 2013 Ruslan Kavetsky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Cursor)

- (void)moveCursorToPosition:(NSInteger)position;
- (NSInteger)cursorPosition;

@end

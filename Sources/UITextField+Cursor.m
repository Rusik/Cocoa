//
//  UITextField+Cursor.m
//
//  Created by Ruslan Kavetsky.
//  Copyright (c) 2013 Ruslan Kavetsky. All rights reserved.
//

#import "UITextField+Cursor.h"

@implementation UITextField (Cursor)

- (void)moveCursorToPosition:(NSInteger)position {
	UITextPosition *start = [self positionFromPosition:[self beginningOfDocument]
	                                            offset:position];
	UITextPosition *end = [self positionFromPosition:start
	                                          offset:0];
	[self setSelectedTextRange:[self textRangeFromPosition:start toPosition:end]];
}

- (NSInteger)cursorPosition {
	UITextRange *selRange = self.selectedTextRange;
	UITextPosition *selStartPos = selRange.start;
	NSInteger idx = [self offsetFromPosition:self.beginningOfDocument toPosition:selStartPos];
	return idx;
}

@end

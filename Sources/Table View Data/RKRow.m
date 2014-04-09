//
//  RKRow.m
//
//  Created by Ruslan Kavetsky.
//  Copyright (c) 2012 Ruslan Kavetsky. All rights reserved.
//

#import "RKRow.h"
#import "UIView+Helpers.h"

@implementation RKRow

#define DEFAULT_CELL_HEIGHT 44

- (instancetype)init {
    self = [super init];
    if (self) {
        _selectable = NO;
    }
    return self;
}

- (float)height {
    if (_selected) {
        return DEFAULT_CELL_HEIGHT + _view.$height;
    } else {
        return DEFAULT_CELL_HEIGHT;
    }
}

- (void)setSelected:(BOOL)selected {
    if (_selectable) {
        _selected = selected;
    }

    if (_selected) {
        [_view becomeFirstResponder];
    } else {
        [_view resignFirstResponder];
    }
}

- (void)performAction {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [_target performSelector:_action];
#pragma clang diagnostic pop
}

@end

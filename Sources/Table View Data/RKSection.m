//
//  RKSection.m
//
//  Created by Ruslan Kavetsky.
//  Copyright (c) 2012 Ruslan Kavetsky. All rights reserved.
//

#import "RKSection.h"

@implementation RKSection {
    NSMutableArray *_rows;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _rows = [NSMutableArray array];
    }
    return self;
}

- (void)addRow:(RKRow *)row {
    [_rows addObject:row];
}

- (RKRow *)rowAtIndex:(NSUInteger)index {
    return _rows[index];
}

- (NSUInteger)numberOfRows {
    return _rows.count;
}

@end

//
//  RKTableData.m
//
//  Created by Ruslan Kavetsky.
//  Copyright (c) 2012 Ruslan Kavetsky. All rights reserved.
//

#import "RKTableData.h"

@implementation RKTableData {
    NSMutableArray *_sections;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _sections = [NSMutableArray array];
    }
    return self;
}

- (void)addSection:(RKSection *)section {
    [_sections addObject:section];
}

- (NSUInteger)numberOfSections {
    return _sections.count;
}

- (RKSection *)sectionAtIndex:(NSInteger)index {
    return _sections[index];
}

- (RKRow *)rowAtIndexPath:(NSIndexPath *)indexPath {
    return [[self sectionAtIndex:indexPath.section] rowAtIndex:indexPath.row];
}

- (void)selectRowAtIndexPath:(NSIndexPath *)indexPath {

    [self deselectAllRows];

    RKRow *row = [[self sectionAtIndex:indexPath.section] rowAtIndex:indexPath.row];
    row.selected = YES;
}

- (void)deselectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self deselectAllRows];
}

- (void)deselectAllRows {
    for (RKSection *section in _sections) {
        for (int i = 0; i < [section numberOfRows]; i++) {
            [section rowAtIndex:i].selected = NO;
        }
    }
}

@end

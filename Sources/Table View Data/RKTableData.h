//
//  RKTableData.h
//
//  Created by Ruslan Kavetsky.
//  Copyright (c) 2012 Ruslan Kavetsky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RKRow.h"
#import "RKSection.h"

@interface RKTableData : NSObject

- (void)addSection:(RKSection *)section;
- (NSUInteger)numberOfSections;
- (RKSection *)sectionAtIndex:(NSInteger)index;
- (RKRow *)rowAtIndexPath:(NSIndexPath *)indexPath;

- (void)selectRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)deselectRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)deselectAllRows;

@end

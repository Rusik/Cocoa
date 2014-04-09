//
//  RKSection.h
//
//  Created by Ruslan Kavetsky.
//  Copyright (c) 2012 Ruslan Kavetsky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RKRow.h"

@interface RKSection : NSObject

- (RKRow *)rowAtIndex:(NSUInteger)index;
- (void)addRow:(RKRow *)row;
- (NSUInteger)numberOfRows;

@property (nonatomic, copy) NSString *title;

@end
//
//  RKRow.h
//
//  Created by Ruslan Kavetsky.
//  Copyright (c) 2012 Ruslan Kavetsky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RKRow : NSObject

- (float)height;
- (void)performAction;

// Может ли ячейка стать выделенной, либо на неё можно только нажать и получить в ответ действие
@property BOOL selectable;

@property (nonatomic) BOOL  selected;
@property (nonatomic, weak) UITableViewCell *cell;
@property (nonatomic, weak) UIView *view;
@property (nonatomic, weak) id target;
@property (nonatomic) SEL   action;

@end

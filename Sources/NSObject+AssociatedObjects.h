//
//  NSObject+AssociatedObjects.h
//
//  Created by Ruslan Kavetsky.
//  Copyright (c) 2014 Ruslan Kavetsky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (AssociatedObjects)

- (void)setAssociatedObject:(id)object forKey:(void *)key;
- (void)setAssociatedWeekObject:(id)object forKey:(void *)key;

- (id)associatedObjectForKey:(void *)key;

@end

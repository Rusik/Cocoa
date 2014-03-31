//
//  NSObject+AssociatedObjects.m
//
//  Created by Ruslan Kavetsky.
//  Copyright (c) 2014 Ruslan Kavetsky. All rights reserved.
//

#import "NSObject+AssociatedObjects.h"
#import <objc/runtime.h>

@implementation NSObject (AssociatedObjects)

- (void)setAssociatedObject:(id)object forKey:(void *)key {
	objc_setAssociatedObject(self, key, object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setAssociatedWeekObject:(id)object forKey:(void *)key {
	objc_setAssociatedObject(self, key, object, OBJC_ASSOCIATION_ASSIGN);
}

- (id)associatedObjectForKey:(void *)key {
	return objc_getAssociatedObject(self, key);
}

@end

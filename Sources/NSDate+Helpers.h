//
//  NSDate+Helpers.h
//
//  Created by Ruslan Kavetsky
//  Copyright (c) 2013 Ruslan Kavetsky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Helpers)

+ (BOOL)date:(NSDate *)date isBetweenDate:(NSDate *)beginDate andDate:(NSDate *)endDate;

- (BOOL)isBetweenDate:(NSDate *)beginDate andDate:(NSDate *)endDate;
- (BOOL)isBeforeDate:(NSDate *)date;
- (BOOL)isAfterDate:(NSDate *)date;

@end

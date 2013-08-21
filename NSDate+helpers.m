//
//  NSDate+Helpers.m
//
//  Created by Ruslan Kavetsky
//  Copyright (c) 2013 Ruslan Kavetsky. All rights reserved.
//

#import "NSDate+Helpers.h"

@implementation NSDate (Helpers)

+ (BOOL)date:(NSDate *)date isBetweenDate:(NSDate *)beginDate andDate:(NSDate *)endDate {
	if ([date compare:beginDate] == NSOrderedAscending)
		return NO;

	if ([date compare:endDate] == NSOrderedDescending)
		return NO;

	return YES;
}

- (BOOL)isBetweenDate:(NSDate *)beginDate andDate:(NSDate *)endDate {
	return [NSDate date:self isBetweenDate:beginDate andDate:endDate];
}

- (BOOL)isBeforeDate:(NSDate *)date {
	return [self earlierDate:date] == self;
}

- (BOOL)isAfterDate:(NSDate *)date {
	return [self laterDate:date] == self;
}

@end

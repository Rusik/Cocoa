//
//  NSObject+ios7support.h
//  choicer
//
//  Created by Ruslan Kavetsky.
//  Copyright (c) 2013 Ruslan Kavetsky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (ios7support)

+ (void)performForIos6:(void (^)())ios6Block ios7:(void (^)())ios7Block;
- (void)performForIos6:(void (^)())ios6Block ios7:(void (^)())ios7Block;

- (void)performForIos6:(void (^)())ios6Block;
+ (void)performForIos6:(void (^)())ios6Block;

- (void)performForIos7:(void (^)())ios7Block;
+ (void)performForIos7:(void (^)())ios7Block;

@end

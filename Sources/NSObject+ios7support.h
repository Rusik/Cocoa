//
//  NSObject+ios7support.h
//  choicer
//
//  Created by Ruslan Kavetsky.
//  Copyright (c) 2013 Ruslan Kavetsky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (ios7support)

+ (void)performForIos6Block:(void (^)())ios6Block ios7Block:(void (^)())ios7Block;
- (void)performForIos6Block:(void (^)())ios6Block ios7Block:(void (^)())ios7Block;

@end

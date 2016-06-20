//
//  FuncObjc.h
//  funcobjc
//
//  Created by Alexander Smirnov on 06/06/16.
//  Copyright © 2016 Alexander Smirnov. All rights reserved.
//

#import "NSArray+Func.h"
#import "NSDictionary+Func.h"
#import "FuncShortcuts.h"

/**
 Dictionary access safety function.
 @param dict The original dictionary or nil.
 @return original dictionary or @{} in case of 'nil' param passed
 */
NSDictionary* __attribute__((overloadable)) f_(NSDictionary *dict);

/**
 Array access safety function.
 @param array The original array or nil.
 @return original array or @[] in case of 'nil' param passed.
 */
NSArray* __attribute__((overloadable)) f_(NSArray *array);

/**
 Generates array of numbers increasing from 0 to length.
 @param length The length of the resulting array.
 @return array of numbers, i.e. @[ @0, @1, @2 ] for length = 3
 */
NSArray* __attribute__((overloadable)) f_range(NSUInteger length);

/**
 Generates array of numbers increasing from 'start' to 'length'.
 @param start The first value in the resulting array.
 @param length The length of the resulting array.
 @return array of numbers, i.e. @[ @0, @1, @2 ] for length = 3
 */
NSArray* __attribute__((overloadable)) f_range(NSUInteger start, NSUInteger length);




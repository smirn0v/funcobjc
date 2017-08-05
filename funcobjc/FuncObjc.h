//
//  FuncObjc.h
//  funcobjc
//
//  Created by Alexander Smirnov on 06/06/16.
//

#import "NSArray+Func.h"
#import "NSDictionary+Func.h"
#import "NSSet+Func.h"
#import "FuncShortcuts.h"
#import "FNPair.h"

/**
 `f_nonNull` function loses generic type of argument.
 `f_` adds source generic type to result type
 */
#define f_(...) ((typeof((__VA_ARGS__).f_self)) f_nonNull(__VA_ARGS__))

/**
 Dictionary access safety function.
 @param dict The original dictionary or nil.
 @return original dictionary or @{} in case of 'nil' param passed
 */

NSDictionary *f_nonNull(NSDictionary *dict) __attribute__((overloadable));

/**
 Array access safety function.
 @param array The original array or nil.
 @return original array or @[] in case of 'nil' param passed.
 */
NSArray *f_nonNull(NSArray *array) __attribute__((overloadable));

/**
 Set access safety function.
 @param set The original set or nil.
 @return original set or new empty set in case of 'nil' param passed.
 */
NSSet *f_nonNull(NSSet *set) __attribute__((overloadable));

/**
 Generates array of numbers increasing from 0 to length.
 @param length The length of the resulting array.
 @return array of numbers, i.e. @[ @0, @1, @2 ] for length = 3
 */
NSArray<NSNumber *> *f_range(NSUInteger length) __attribute__((overloadable));

/**
 Generates array of numbers increasing from 'start' to 'start + length - 1'.
 @param start The first value in the resulting array.
 @param length The length of the resulting array.
 @return array of numbers, i.e. @[ @10, @11, @12 ] for start = 10, length = 3
 */
NSArray<NSNumber *> *f_range(NSUInteger start, NSUInteger length)  __attribute__((overloadable));

/**
 Generates array of numbers increasing from 'start' to 'start + step*(length - 1)'.
 @param start The first value in the resulting array.
 @param length The length of the resulting array.
 @return array of numbers, i.e. @[ @10, @20, @30 ] for start = 10, length = 3, step = 10
 */
NSArray<NSNumber *> *f_range(NSUInteger start, NSUInteger length, NSUInteger step) __attribute__((overloadable));

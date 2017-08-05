//
//  FuncObjc.m
//  funcobjc
//
//  Created by Alexander Smirnov on 21/06/16.
//

#import <Foundation/Foundation.h>
#import "FuncObjc.h"

NSDictionary *f_nonNull(NSDictionary *dict) __attribute__((overloadable)) {
    return (dict ?: @{});
}

NSArray *f_nonNull(NSArray* a) __attribute__((overloadable)) {
    return (a ?: @[]);
}

NSSet *f_nonNull(NSSet *s) __attribute__((overloadable)) {
    return (s ?: [NSSet set]);
}

NSArray *f_range(NSUInteger length) __attribute__((overloadable)) {
    return f_range(0, length, 1);
}

NSArray *f_range(NSUInteger start, NSUInteger length) __attribute__((overloadable)) {
    return f_range(start, length, 1);
}

NSArray *f_range(NSUInteger start, NSUInteger length, NSUInteger step) __attribute__((overloadable)) {
    NSMutableArray *result = [NSMutableArray arrayWithCapacity: length];
    for (NSUInteger i = 0; i < length; ++i) {
        [result addObject:@(start + i * step)];
    }
    return result;
}

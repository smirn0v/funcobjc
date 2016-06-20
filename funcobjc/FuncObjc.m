//
//  FuncObjc.m
//  funcobjc
//
//  Created by Alexander Smirnov on 21/06/16.
//  Copyright © 2016 Alexander Smirnov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FuncObjc.h"

NSDictionary* __attribute__((overloadable)) f_(NSDictionary *d) {
    return d?:@{};
}

NSArray* __attribute__((overloadable)) f_(NSArray* a) {
    return a?:@[];
}

NSArray* __attribute__((overloadable)) f_range(NSUInteger length) {
    return f_range(0, length);
}

NSArray* __attribute__((overloadable)) f_range(NSUInteger start, NSUInteger length) {
    NSMutableArray *result = [NSMutableArray arrayWithCapacity: length];
    for(NSUInteger i = start; i < (start+length); i++) {
        [result addObject: @(i)];
    }
    return result;
}
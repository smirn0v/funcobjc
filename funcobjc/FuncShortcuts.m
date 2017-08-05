//
//  FuncShortcuts.m
//  funcobjc
//
//  Created by Alexander Smirnov on 06/06/16.
//

#import <Foundation/Foundation.h>
#import "FuncShortcuts.h"

#pragma mark - General

f_predicate_block f_not(f_predicate_block predicate) {
    return ^BOOL(id obj) {
        return !predicate(obj);
    };
}

f_equal_block f_equal(void) {
    return ^BOOL(id o1, id o2) {
        return o1 == nil ? o2 == nil : [o1 isEqual: o2];
    };
}

#pragma mark - NSString

f_map_block f_uppercase(void) {
    return ^NSString*(NSString* el) {
        return [el uppercaseString];
    };
}

#pragma mark - NSNumber

f_map_block f_inc(void) {
    return ^NSNumber*(NSNumber* el) {
        return @(el.integerValue + 1);
    };
}

//
//  FuncShortcuts.m
//  funcobjc
//
//  Created by Alexander Smirnov on 06/06/16.
//

#import <Foundation/Foundation.h>
#import "FuncShortcuts.h"

#pragma mark - NSString

func_map_block func_uppercase(void) {
    return ^NSString*(NSString* el) {
        return [el uppercaseString];
    };
}

#pragma mark - NSNumber

func_map_block func_inc(void) {
    return ^NSNumber*(NSNumber* el) {
        return @(el.integerValue + 1);
    };
}

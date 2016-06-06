//
//  NSArray+Func.m
//  funcobjc
//
//  Created by Alexander Smirnov on 06/06/16.
//  Copyright © 2016 Alexander Smirnov. All rights reserved.
//

#import "NSArray+Func.h"

@implementation NSArray (Func)

- (NSArray*(^)(id(^)(id))) f_map {
    return ^NSArray*(id(^f)(id)) {
        return self.f_reduce(@[], ^id(NSArray* initial, id el) {
            id map_result = f(el);
            return map_result ? [initial arrayByAddingObject: map_result] : initial;
        });
    };
}

- (NSArray*(^)(BOOL(^)(id))) f_filter {
    return ^NSArray*(BOOL(^f)(id)) {
        return self.f_reduce(@[], ^id(NSArray* initial, id el) { return (f(el) && el) ? [initial arrayByAddingObject:el] : initial; });
    };
}

- (id(^)(id, id(^)(id,id))) f_reduce {
    return ^id(id initial, id(^combine)(id,id)) {
        id result = initial;
        for(id el in self) {
            result = combine(result, el);
        }
        return result;
    };
}

- (NSDictionary*) f_dict {
    return self.f_reduce(@{}.mutableCopy, ^id(NSMutableDictionary* initial, id el) { return ({ initial[el] = el; initial; }); });
}

- (NSString*(^)(NSString*)) f_join {
    return ^NSString*(NSString *j) {
        return [self componentsJoinedByString: j];
    };
}

@end

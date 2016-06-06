//
//  NSDictionary+Func.m
//  funcobjc
//
//  Created by Alexander Smirnov on 06/06/16.
//  Copyright © 2016 Alexander Smirnov. All rights reserved.
//

#import "NSDictionary+Func.h"

@implementation NSDictionary (Func)

- (NSDictionary*(^)(NSDictionary*(^)(id,id))) f_map {
    return ^NSDictionary*(NSDictionary*(^f)(id,id)) {
        return self.f_reduce(@{}.mutableCopy,^id(NSMutableDictionary* initial, id key, id value) {
            NSDictionary* map_result = f(key,value);
            if(map_result) {
                [initial addEntriesFromDictionary: map_result];
            }
            return initial;
        });
    };
}

- (NSDictionary*(^)(BOOL(^)(id,id))) f_filter {
    return ^NSDictionary*(BOOL(^f)(id,id)) {
        return self.f_reduce(@{}.mutableCopy,^id(NSMutableDictionary* initial, id key, id value) {
            if(f(key,value)) {
                [initial addEntriesFromDictionary:@{key: value}];
            }
            return initial;
        });
    };
}

- (id(^)(id, id(^)(id,id,id))) f_reduce {
    return ^id(id initial, id(^combine)(id,id,id)) {
        id result = initial;
        for(id key in self) {
            result = combine(result, key, self[key]);
        }
        return result;
    };
}

@end

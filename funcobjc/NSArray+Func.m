//
//  NSArray+Func.m
//  funcobjc
//
//  Created by Alexander Smirnov on 06/06/16.
//  Copyright © 2016 Alexander Smirnov. All rights reserved.
//

#import "NSArray+Func.h"

typedef BOOL (^Predicate)(id);
typedef id (^Function)(id);
typedef id (^Function2)(id, id);

@implementation NSArray (Func)

- (NSArray * (^)(id(^)(id))) f_map {
    return ^NSArray * (Function f) {
        NSMutableArray *array = self.f_reduce([NSMutableArray array], ^NSMutableArray * (NSMutableArray *result, id el) {
            id map_result = f(el);
            if (map_result) {
                [result addObject:map_result];
            }
            return result;
        });
        return [NSArray arrayWithArray:array];
    };
}

- (NSArray * (^)(Predicate))f_filter {
    return ^NSArray * (Predicate f) {
        NSMutableArray *array = self.f_reduce([NSMutableArray array], ^NSMutableArray * (NSMutableArray *result, id el) {
            if (f(el)) {
                [result addObject:el];
            }
            return result;
        });
        return [NSArray arrayWithArray:array];
    };
}

- (id (^)(id, Function2)) f_reduce {
    return ^id(id initial, Function2 combine) {
        id result = initial;
        for(id el in self) {
            result = combine(result, el);
        }
        return result;
    };
}

- (NSDictionary *)f_dict {
    return self.f_reduce(@{}.mutableCopy, ^id(NSMutableDictionary* initial, id el) {
        return ({ initial[el] = el; initial; });
    });
}

- (NSString* (^)(NSString*)) f_join {
    return ^NSString* (NSString *j) {
        return [self componentsJoinedByString:j];
    };
}

@end

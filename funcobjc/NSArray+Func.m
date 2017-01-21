//
//  NSArray+Func.m
//  funcobjc
//
//  Created by Alexander Smirnov on 06/06/16.
//

#import "NSArray+Func.h"

typedef BOOL (^Predicate)(id);
typedef id (^Function)(id);
typedef id (^Function2)(id, id);

@implementation NSArray (Func)

- (NSArray * (^)(id(^)(id))) f_map {
    return ^NSArray * (Function f) {
        NSMutableArray *array = self.f_reduce([NSMutableArray arrayWithCapacity: self.count], ^NSMutableArray * (NSMutableArray *result, id el) {
            id map_result = f(el);
            if (map_result) {
                [result addObject:map_result];
            }
            return result;
        });
        return [NSArray arrayWithArray:array];
    };
}

- (NSArray *(^)(NSArray *(^)(id))) f_flattenMap {
    return ^NSArray *(NSArray *(^f)(id)) {
        NSMutableArray *array = self.f_reduce([NSMutableArray array], ^id(NSMutableArray* initial, id el) {
            NSArray *result = f(el);
            if (result.count > 0) {
                [initial addObjectsFromArray:result];
            }
            return initial;
        });
        return [NSArray arrayWithArray:array];
    };
}

- (NSArray * (^)(Predicate))f_filter {
    return ^NSArray * (Predicate f) {
        NSMutableArray *array = self.f_reduce([NSMutableArray arrayWithCapacity: self.count], ^NSMutableArray * (NSMutableArray *result, id el) {
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

- (BOOL (^)(BOOL (^)(id)))f_all {
    return ^BOOL (BOOL(^predicate)(id)) {
        return !self.f_any(^BOOL(id obj) {
            return !predicate(obj);
        });
    };
}

- (BOOL(^)(BOOL(^)(id)))f_any {
    return ^BOOL (BOOL(^predicate)(id)) {
        for (id item in self) {
            if (predicate(item)) {
                return YES;
            }
        }
        return NO;
    };
}

- (id (^)(BOOL(^)(id)))f_first {
    return ^id(BOOL (^predicate)(id)) {
        id passedObject = nil;
        for (id object in self) {
            if (predicate(object)) {
                passedObject = object;
                break;
            }
        }
        return passedObject;
    };
}

- (NSDictionary *)f_dict {
    return self.f_reduce(@{}.mutableCopy, ^id(NSMutableDictionary* initial, id el) {
        return (initial[el] = el, initial);
    });
}

- (NSString* (^)(NSString*)) f_join {
    return ^NSString* (NSString *j) {
        return [self componentsJoinedByString:j];
    };
}

- (NSArray *)f_flatten {
    NSMutableArray *array = @[].mutableCopy;
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:NSArray.class]) {
            [array addObjectsFromArray:(NSArray *)obj];
        } else {
            [array addObject:obj];
        }
    }];
    return array.copy;
}

@end

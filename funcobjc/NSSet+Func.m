//
//  NSSet+Func.m
//  MRMail
//
//  Created by Никита Анисимов on 16/08/16.
//  Copyright © 2016 Mail.Ru. All rights reserved.
//

#import "NSSet+Func.h"

#import "NSArray+Func.h"

typedef BOOL (^Predicate)(id);
typedef id (^Function)(id);
typedef id (^Function2)(id, id);

@implementation NSSet (Func)

- (NSSet * _Nonnull (^)(NS_NOESCAPE id  _Nullable (^ _Nonnull)(id _Nonnull)))f_map {
    return ^NSSet * (Function f) {
        NSMutableSet *set = self.f_reduce([NSMutableSet setWithCapacity:self.count], ^NSMutableSet * (NSMutableSet *result, id el) {
            id map_result = f(el);
            if (map_result) {
                [result addObject:map_result];
            }
            return result;
        });
        return [NSSet setWithSet:set];
    };
}

- (NSSet * _Nonnull (^)(NS_NOESCAPE NSSet * _Nullable (^ _Nonnull)(id _Nonnull)))f_flattenMap {
    return ^NSSet *(NSSet *(^f)(id)) {
        NSMutableSet *set = self.f_reduce([NSMutableSet set], ^id(NSMutableSet* initial, id el) {
            NSSet *result = f(el);
            if (result.count > 0) {
                [initial unionSet:result];
            }
            return initial;
        });
        return [NSSet setWithSet:set];
    };
}

- (NSSet<id> * (^)(NS_NOESCAPE Predicate))f_filter {
    return ^NSSet * (Predicate f) {
        NSMutableSet *set = self.f_reduce([NSMutableSet setWithCapacity:self.count], ^NSMutableSet * (NSMutableSet *result, id el) {
            if (f(el)) {
                [result addObject:el];
            }
            return result;
        });
        return [NSSet setWithSet:set];
    };
}

- (id (^)(id, NS_NOESCAPE Function2)) f_reduce {
    return ^id(id initial, Function2 _Nonnull combine) {
        id result = initial;
        for(id el in self) {
            result = combine(result, el);
        }
        return result;
    };
}

- (BOOL (^)(NS_NOESCAPE BOOL (^)(id)))f_all {
    return ^BOOL (BOOL(^predicate)(id)) {
        return !self.f_any(^BOOL(id obj) {
            return !predicate(obj);
        });
    };
}

- (BOOL(^)(NS_NOESCAPE BOOL(^)(id)))f_any {
    return ^BOOL (BOOL(^ _Nonnull predicate)(id)) {
        for (id item in self) {
            if (predicate(item)) {
                return YES;
            }
        }
        return NO;
    };
}

- (id  _Nullable (^)(NS_NOESCAPE BOOL (^ _Nonnull)(id _Nonnull)))f_first {
    return ^id(BOOL (^ _Nonnull predicate)(id)) {
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

- (NSString *(^)(NSString *))f_join {
    return self.allObjects.f_join;
}

- (NSDictionary *)f_dict {
    return self.f_reduce(@{}.mutableCopy, ^id(NSMutableDictionary* initial, id el) {
        initial[el] = el;
        return initial;
    });
}

- (NSSet *)f_flatten {
    NSMutableSet *set = [NSMutableSet set];
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:NSSet.class]) {
            [set unionSet:(NSSet*)obj];
        } else {
            [set addObject:obj];
        }
    }];
    return set.copy;
}

- (NSSet *)f_self {
    return self;
}

@end

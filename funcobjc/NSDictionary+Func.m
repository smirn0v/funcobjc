//
//  NSDictionary+Func.m
//  funcobjc
//
//  Created by Alexander Smirnov on 06/06/16.
//  Copyright © 2016 Alexander Smirnov. All rights reserved.
//

#import "NSDictionary+Func.h"

@implementation NSDictionary (Func)

- (instancetype)f_initWithPairs:(NSArray<FNPair *> *)pairs {
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithCapacity:pairs.count];
    for (FNPair *pair in pairs) {
        if (!pair.first) {
            continue;
        }
        if (!pair.second) {
            continue;
        }
        dictionary[pair.first] = pair.second;
    }
    return [self initWithDictionary:dictionary];
}

- (NSDictionary*(^)(NS_NOESCAPE NSDictionary*(^)(id,id))) f_map {
    return ^NSDictionary*(NSDictionary*(^ _Nonnull f)(id,id)) {
        return self.f_reduce(@{}.mutableCopy,^id(NSMutableDictionary* initial, id key, id value) {
            NSDictionary* map_result = f(key,value);
            if(map_result) {
                [initial addEntriesFromDictionary: map_result];
            }
            return initial;
        });
    };
}

- (NSDictionary<id, id> *(^)(NS_NOESCAPE BOOL(^)(id,id))) f_filter {
    return ^NSDictionary*(BOOL(^ _Nonnull f)(id,id)) {
        return self.f_reduce(@{}.mutableCopy,^id(NSMutableDictionary* initial, id key, id value) {
            if(f(key,value)) {
                [initial addEntriesFromDictionary:@{key: value}];
            }
            return initial;
        });
    };
}

- (id  _Nonnull (^)(id _Nonnull, NS_NOESCAPE id  _Nonnull (^ _Nonnull)(id _Nonnull, id _Nonnull, id _Nonnull)))f_reduce {
    return ^id(id initial, id(^ _Nonnull combine)(id,id,id)) {
        id result = initial;
        for(id key in self) {
            result = combine(result, key, self[key]);
        }
        return result;
    };
}

- (void (^)(NS_NOESCAPE void (^ _Nonnull)(id _Nonnull, id _Nonnull)))f_each {
    return ^(void(^ _Nonnull action)(id _Nonnull, id _Nonnull)) {
        for (id key in self) {
            id value = self[key];
            action(key, value);
        }
    };
}

- (NSDictionary *)f_self {
    return self;
}

@end

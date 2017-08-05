//
//  NSDictionary+Func.m
//  funcobjc
//
//  Created by Alexander Smirnov on 06/06/16.
//

#import "NSDictionary+Func.h"

@implementation NSDictionary (Func)

- (instancetype)f_initWithPairs:(NSArray<FNPair *> *)pairs {
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithCapacity:pairs.count];
    for (FNPair *pair in pairs) {
        NSAssert(pair.first, @"first object of %@ pair can't be equal to `nil`", pair);
        if (!pair.first) {
            continue;
        }
        NSAssert(pair.second, @"second object of %@ pair can't be equal to `nil`", pair);
        if (!pair.second) {
            continue;
        }
        dictionary[pair.first] = pair.second;
    }
    return [self initWithDictionary:dictionary];
}

- (NSDictionary*(^)(NSDictionary*(^)(id,id))) f_map {
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

- (NSDictionary<id, id> *(^)(BOOL(^)(id,id))) f_filter {
    return ^NSDictionary*(BOOL(^ _Nonnull f)(id,id)) {
        return self.f_reduce(@{}.mutableCopy,^id(NSMutableDictionary* initial, id key, id value) {
            if(f(key,value)) {
                [initial addEntriesFromDictionary:@{key: value}];
            }
            return initial;
        });
    };
}

- (id(^)(id, id(^)(id,id,id))) f_reduce {
    return ^id(id initial, id(^ _Nonnull combine)(id,id,id)) {
        id result = initial;
        for(id key in self) {
            result = combine(result, key, self[key]);
        }
        return result;
    };
}

- (NSDictionary *)f_self {
    return self;
}

@end

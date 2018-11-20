//
//  NSMapTable+Func.m
//  MRMail
//
//  Created by Nikolay Morev on 03/11/2017.
//  Copyright © 2017 Mail.Ru. All rights reserved.
//

#import "NSMapTable+Func.h"
#import "NSHashTable+Func.h"

typedef BOOL (^KeyValuePredicate)(id _Nonnull, id _Nonnull);

@implementation NSMapTable (Func)

- (void (^)(NS_NOESCAPE void (^ _Nonnull)(id _Nonnull, id _Nonnull)))f_each {
    return ^(void (^ _Nonnull action)(id _Nonnull, id _Nonnull)) {
        for (id key in self) {
            action(key, (id _Nonnull)[self objectForKey:key]);
        }
    };
}

- (NSHashTable<id> * _Nonnull (^)(NS_NOESCAPE KeyValuePredicate))f_filteredKeys {
    return ^NSHashTable * (KeyValuePredicate pred) {
        NSHashTable *keys = [[NSHashTable alloc] initWithPointerFunctions:self.keyPointerFunctions capacity:self.count];
        self.f_each(^(id key, id value) {
            if (pred(key, value)) {
                [keys addObject:key];
            }
        });
        return keys;
    };
}

- (NSMapTable<id, id> * _Nonnull (^)(NS_NOESCAPE KeyValuePredicate))f_filter {
    return ^NSMapTable * (KeyValuePredicate pred) {
        self.f_filteredKeys(^BOOL (id key, id value) {
            return !pred(key, value);
        }).f_each(^(id key) {
            [self removeObjectForKey:key];
        });
        return self;
    };
}

- (id(^)(id, NS_NOESCAPE id(^)(id,id,id))) f_reduce {
    return ^id(id initial, id(^ _Nonnull combine)(id,id,id)) {
        id result = initial;
        for(id key in self) {
            result = combine(result, key, [self objectForKey:key]);
        }
        return result;
    };
}

@end

//
//  NSArray+Func.m
//  funcobjc
//
//  Created by Alexander Smirnov on 06/06/16.
//  Copyright © 2016 Alexander Smirnov. All rights reserved.
//

#import "NSArray+Func.h"
#import "FNPair.h"

typedef BOOL (^Predicate)(id);
typedef id (^Function)(id);
typedef id (^Function2)(id, id);

@implementation NSArray (Func)

- (NSArray * _Nonnull (^)(NS_NOESCAPE id  _Nullable (^ _Nonnull)(id _Nonnull)))f_map {
    return ^NSArray * (Function f) {
        NSMutableArray *mappedItems = [[NSMutableArray alloc] initWithCapacity:self.count];
        for (id item in self) {
            id mappedItem = f(item);
            if (mappedItem) {
                [mappedItems addObject:mappedItem];
            }
        }
        return mappedItems;
    };
}

- (NSArray * _Nonnull (^)(NS_NOESCAPE id  _Nullable (^ _Nonnull)(id _Nonnull, NSUInteger idx)))f_indexedMap {
    return ^NSArray * (id (^f)(id, NSUInteger)) {
        __block NSUInteger idx = 0;
        return self.f_map(^id (id obj) {
            id result = f(obj, idx);
            idx++;
            return result;
        });
    };
}

- (NSDictionary * _Nonnull (^)(NS_NOESCAPE NSDictionary * _Nonnull (^ _Nonnull)(id _Nonnull)))f_mapToDictionary {
    return ^NSDictionary*(NSDictionary*(^ _Nonnull f)(id)) {
        return self.f_reduce(@{}.mutableCopy,^id(NSMutableDictionary* initial, id value) {
            NSDictionary *map_result = f(value);
            if (map_result) {
                [initial addEntriesFromDictionary:map_result];
            }
            return initial;
        });
    };
}

- (NSArray * _Nonnull (^)(NS_NOESCAPE NSArray * _Nullable (^ _Nonnull)(id _Nonnull)))f_flattenMap {
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

- (NSArray<id> * (^)(NS_NOESCAPE Predicate))f_filter {
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
    return ^BOOL (BOOL(^ _Nonnull predicate)(id)) {
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

- (NSUInteger (^)(NS_NOESCAPE BOOL (^ _Nonnull)(id _Nonnull)))f_firstIndex {
    return ^NSUInteger (BOOL (^ _Nonnull predicate)(id)) {
        NSUInteger idx = 0;
        for (id object in self) {
            if (predicate(object)) {
                return idx;
            }
            idx++;
        }
        return NSNotFound;
    };
}

- (NSArray<id> * (^)(NS_NOESCAPE BOOL (^)(id, NSUInteger idx)))f_takeUntil {
    return ^NSArray * (BOOL (^ _Nonnull predicate)(id, NSUInteger idx)) {
        NSMutableArray *result = [NSMutableArray array];
        NSUInteger idx = 0;
        for (id obj in self) {
            if (predicate(obj, idx)) {
                break;
            }
            else {
                [result addObject:obj];
            }
            idx++;
        }
        return [result copy];
    };
}

- (id  _Nullable (^)(NS_NOESCAPE BOOL (^ _Nonnull)(id _Nonnull)))f_last {
    return ^id(BOOL (^predicate)(id)) {
        __block id passedObject = nil;
        [self enumerateObjectsWithOptions:NSEnumerationReverse
                               usingBlock:^(id object, NSUInteger idx, BOOL *stop) {
                                   if (predicate(object)) {
                                       passedObject = object;
                                       *stop = YES;
                                   }
                               }];
        return passedObject;
    };
}

- (id _Nullable(^)(NSComparisonResult(^NS_NOESCAPE)(id obj1, id obj2)))f_min {
    return ^id(NSComparisonResult(^comparator)(id, id)) {
        NSUInteger itemsCount = self.count;
        if (itemsCount == 0) {
            return nil;
        }
        id minItem = self.firstObject;
        for (NSUInteger i = 1; i < itemsCount; ++i) {
            id item = self[i];
            if (comparator(minItem, item) == NSOrderedDescending) {
                minItem = item;
            }
        }
        return minItem;
    };
}

- (NSDictionary *)f_dict {
    return self.f_reduce(@{}.mutableCopy, ^id(NSMutableDictionary* initial, id el) {
        initial[el] = el;
        return initial;
    });
}

- (NSDictionary<id, id> * _Nonnull (^)(NS_NOESCAPE id  _Nonnull (^ _Nonnull)(id _Nonnull)))f_dictByKey {
    return ^NSDictionary * (id (^ _Nonnull action)(id)) {
        return self.f_reduce(@{}.mutableCopy, ^id(NSMutableDictionary* initial, id el) {
            id key = action(el);
            if (key) {
                initial[key] = el;
            }
            return initial;
        });
    };
}

- (NSArray<id> *(^)(NSArray<id> *))f_concat {
    return ^NSArray *(NSArray *array){
        if (!array.count) {
            return [self copy];
        }
        NSArray *result = [self arrayByAddingObjectsFromArray:array];

        return result;
    };
}

- (NSString* (^)(NSString*)) f_join {
    return ^NSString* (NSString *j) {
        return [self componentsJoinedByString:j];
    };
}

- (NSArray<id> * (^)(NSUInteger))f_skip {
    return ^NSArray *(NSUInteger skipCount) {
        if (skipCount >= self.count) {
            return @[];
        }
        NSArray *subarray = [self subarrayWithRange:NSMakeRange(skipCount, self.count - skipCount)];

        return subarray;
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

- (NSArray<id> * (^)(NSUInteger, NSUInteger))f_slice {
    return ^NSArray * (NSUInteger begin, NSUInteger end) {
        if (self.count == 0) {
            return @[];
        }
        if (begin >= end) {
            return @[];
        }
        if (begin > self.count - 1) {
            return @[];
        }
        if (end > self.count - 1) {
            return self.f_skip(begin);
        }
        NSRange range = NSMakeRange(begin, end - begin);
        return [self subarrayWithRange:range];
    };
}

- (NSArray<id> * _Nonnull)f_unique {
#ifdef __INFER__
    return @[];
#else
    return [self filterUnique](nil);
#endif
}

- (NSArray<id> * _Nonnull (^)(NS_NOESCAPE id  _Nonnull (^ _Nonnull)(id _Nonnull)))f_uniqueByKey {
    return [self filterUnique];
}

- (void (^)(NS_NOESCAPE void (^ _Nonnull)(id _Nonnull)))f_each {
    return ^(void(^ _Nonnull action)(id _Nonnull)) {
        for (id object in self) {
            action(object);
        }
    };
}

- (BOOL(^)(NSArray<id>*,BOOL(^)(id,id)))f_equal {
    return ^BOOL(NSArray<id>* array, BOOL(^predicate)(id,id)) {
        
        if(self == array) {
            return YES;
        }
        
        if(!array || self.count != array.count) {
            return NO;
        }
        
        __block BOOL isEqual = YES;
        [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if(!predicate(obj,array[idx])) {
                isEqual = NO;
                *stop   = YES;
            }
        }];
        
        return isEqual;
    };
}

- (NSDictionary<id, NSArray<id> *> *(^)(NS_NOESCAPE id(^ _Nonnull)(id _Nonnull)))f_groupBy {
    return ^NSDictionary<id, NSArray<id> *> *(id(^ _Nonnull keyFunc)(id _Nonnull)) {
        NSMutableDictionary<id, NSArray<id> *> *ret = @{}.mutableCopy;

        for (id object in self) {
            id key = keyFunc(object);
            if (key) {
                NSArray *group = ret[key] ?: @[];
                ret[key] = [group arrayByAddingObject:object];
            }
        }

        return ret.copy;
    };
}

- (FNPair<NSArray *, NSArray *> *)f_unzip_pairs {
    NSArray *first = self.f_map(^id (FNPair *pair) {
        return pair.first;
    });
    NSArray *second = self.f_map(^id (FNPair *pair) {
        return pair.second;
    });
    return [[FNPair<NSArray *, NSArray *> alloc] initWithFirst:first second:second];
}

- (NSArray *)f_self {
    return self;
}

#pragma mark - Private

- (NSArray * _Nonnull (^ _Nonnull)(id(^ _Nullable)(id _Nonnull)))filterUnique {
    return ^id(id(^comparisonValueBlock)(id)) {
        if (!comparisonValueBlock) {
            return [NSOrderedSet orderedSetWithArray:self].array;
        }
        NSMutableSet *set = [NSMutableSet set];
        NSMutableArray *results = @[].mutableCopy;
        [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            id comparisonValue = comparisonValueBlock(obj);
            if (comparisonValue && ![set containsObject:comparisonValue]) {
                [set addObject:comparisonValue];
                [results addObject:obj];
            }
        }];
        return results.copy;
    };
}

@end

//
//  NSDictionary+Func.h
//  funcobjc
//
//  Created by Alexander Smirnov on 06/06/16.
//

#import <Foundation/Foundation.h>
#import "FNPair.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary<__covariant KeyType, __covariant ObjectType> (Func)

- (instancetype)f_initWithPairs:(NSArray<FNPair<KeyType, ObjectType> *> *)pairs;

- (NSDictionary *(^)(NSDictionary *(^NS_NOESCAPE)(KeyType, ObjectType)))f_map;
- (NSDictionary<KeyType, ObjectType> *(^)(BOOL(^NS_NOESCAPE)(KeyType, ObjectType)))f_filter;
- (id(^)(id, id(^NS_NOESCAPE)(id, KeyType, ObjectType)))f_reduce;

// Package methods

- (NSDictionary<KeyType, ObjectType> *)f_self;

@end

NS_ASSUME_NONNULL_END

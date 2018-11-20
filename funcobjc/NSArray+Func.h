//
//  NSArray+Func.h
//  funcobjc
//
//  Created by Alexander Smirnov on 06/06/16.
//  Copyright © 2016 Alexander Smirnov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FNPair.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSArray<__covariant ObjectType> (Func)

- (NSArray *(^)(id _Nullable(^NS_NOESCAPE)(ObjectType)))f_map;
- (NSDictionary *(^)(NSDictionary *(^NS_NOESCAPE)(ObjectType)))f_mapToDictionary;
- (NSArray *(^)(id _Nullable(^NS_NOESCAPE)(ObjectType, NSUInteger idx)))f_indexedMap;
- (NSArray *(^)(NSArray *_Nullable(^NS_NOESCAPE)(ObjectType)))f_flattenMap;
- (NSArray<ObjectType> *(^)(BOOL(^NS_NOESCAPE)(ObjectType)))f_filter;
- (id(^)(id, id(^NS_NOESCAPE)(id, ObjectType)))f_reduce;

- (BOOL(^)(BOOL(^NS_NOESCAPE)(ObjectType)))f_all;
- (BOOL(^)(BOOL(^NS_NOESCAPE)(ObjectType)))f_any;
- (ObjectType _Nullable (^)(BOOL(^NS_NOESCAPE)(ObjectType)))f_first;
- (NSUInteger (^)(BOOL(^NS_NOESCAPE)(ObjectType)))f_firstIndex;
- (NSArray<ObjectType> *(^)(BOOL(^NS_NOESCAPE)(ObjectType, NSUInteger idx)))f_takeUntil;
- (ObjectType _Nullable(^)(BOOL(^NS_NOESCAPE)(ObjectType)))f_last;

- (ObjectType _Nullable(^)(NSComparisonResult(^NS_NOESCAPE)(ObjectType obj1, ObjectType obj2)))f_min;

- (NSDictionary<ObjectType, ObjectType> *)f_dict;
- (NSDictionary<id, ObjectType> *(^)(id(^NS_NOESCAPE)(ObjectType)))f_dictByKey;
- (NSArray<ObjectType> *(^)(NSArray<ObjectType> *_Nullable))f_concat;
- (NSString *(^)(NSString *))f_join;

- (NSArray<ObjectType> *(^)(NSUInteger))f_skip;

- (NSArray *)f_flatten;
- (NSArray<ObjectType> *(^)(NSUInteger, NSUInteger))f_slice;

// Выборка уникальных элементов с сохранением (!) порядка
- (NSArray<ObjectType> *)f_unique;
- (NSArray<ObjectType> *(^)(id(^NS_NOESCAPE)(ObjectType)))f_uniqueByKey;

- (void(^)(void(^NS_NOESCAPE)(ObjectType)))f_each;

- (BOOL(^)(NSArray<ObjectType>*,BOOL(^)(ObjectType,ObjectType)))f_equal;

- (NSDictionary<id, NSArray<ObjectType> *> *(^)(id(^NS_NOESCAPE)(ObjectType)))f_groupBy;

- (FNPair<NSArray *, NSArray *> *)f_unzip_pairs;

// Package methods

- (NSArray<ObjectType> *)f_self;

@end

NS_ASSUME_NONNULL_END

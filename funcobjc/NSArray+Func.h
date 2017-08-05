//
//  NSArray+Func.h
//  funcobjc
//
//  Created by Alexander Smirnov on 06/06/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray<__covariant ObjectType> (Func)

- (NSArray *(^)(id _Nullable(^NS_NOESCAPE)(ObjectType)))f_map;
- (NSArray *(^)(id _Nullable(^NS_NOESCAPE)(ObjectType, NSUInteger idx)))f_indexedMap;
- (NSArray *(^)(NSArray *_Nullable(^NS_NOESCAPE)(ObjectType)))f_flattenMap;
- (NSArray<ObjectType> *(^)(BOOL(^NS_NOESCAPE)(ObjectType)))f_filter;
- (id(^)(id, id(^NS_NOESCAPE)(id, ObjectType)))f_reduce;

- (BOOL(^)(BOOL(^NS_NOESCAPE)(ObjectType)))f_all;
- (BOOL(^)(BOOL(^NS_NOESCAPE)(ObjectType)))f_any;
- (ObjectType _Nullable (^)(BOOL(^NS_NOESCAPE)(ObjectType)))f_first;
- (NSArray<ObjectType> *(^)(BOOL(^NS_NOESCAPE)(ObjectType, NSUInteger idx)))f_takeUntil;
- (ObjectType _Nullable(^)(BOOL(^NS_NOESCAPE)(ObjectType)))f_last;

- (NSDictionary<ObjectType, ObjectType> *)f_dict;
- (NSDictionary<id, ObjectType> *(^)(id(^NS_NOESCAPE)(ObjectType)))f_dictByKey;
- (NSArray<ObjectType> *(^)(NSArray<ObjectType> *_Nullable))f_concat;
- (NSString *(^)(NSString *))f_join;

- (NSArray<ObjectType> *(^)(NSUInteger))f_skip;

- (NSArray *)f_flatten;
- (NSArray<ObjectType> *(^)(NSUInteger, NSUInteger))f_slice;

- (NSArray<ObjectType> *(^)(void))f_unique;
- (NSArray<ObjectType> *(^)(id(^NS_NOESCAPE)(ObjectType)))f_uniqueByKey;

- (void(^)(void(^NS_NOESCAPE)(ObjectType)))f_each;

- (BOOL(^)(NSArray<ObjectType>*,BOOL(^)(ObjectType,ObjectType)))f_equal;

- (NSDictionary<id, NSArray<ObjectType> *> *(^)(id(^NS_NOESCAPE)(ObjectType)))f_groupBy;

// Package methods

- (NSArray<ObjectType> *)f_self;

@end

NS_ASSUME_NONNULL_END

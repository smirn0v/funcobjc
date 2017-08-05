//
//  NSSet+Func.h
//
//  Created by Никита Анисимов on 16/08/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSSet<__covariant ObjectType> (Func)

- (NSSet *(^)(id _Nullable (^NS_NOESCAPE)(ObjectType)))f_map;
- (NSSet *(^)(NSSet *_Nullable(^NS_NOESCAPE)(ObjectType)))f_flattenMap;
- (NSSet<ObjectType> *(^)(BOOL(^NS_NOESCAPE)(ObjectType)))f_filter;
- (id(^)(id, id(^NS_NOESCAPE)(id, ObjectType)))f_reduce;

- (BOOL(^)(BOOL(^NS_NOESCAPE)(ObjectType)))f_all;
- (BOOL(^)(BOOL(^NS_NOESCAPE)(ObjectType)))f_any;
- (ObjectType _Nullable (^)(BOOL(^NS_NOESCAPE)(ObjectType)))f_first;

- (NSString *(^)(NSString *))f_join;
- (NSDictionary<ObjectType, ObjectType> *)f_dict;

- (NSSet *)f_flatten;

// Package methods

- (NSSet<ObjectType> *)f_self;

@end

NS_ASSUME_NONNULL_END

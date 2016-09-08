//
//  NSSet+Func.h
//  MRMail
//
//  Created by Никита Анисимов on 16/08/16.
//  Copyright © 2016 Mail.Ru. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSSet (Func)

- (NSSet*(^)(id(^)(id)))        f_map;
- (NSSet*(^)(NSSet *(^)(id)))   f_flattenMap;
- (NSSet*(^)(BOOL(^)(id)))      f_filter;
- (id(^)(id, id(^)(id,id)))     f_reduce;

- (BOOL(^)(BOOL(^)(id)))        f_all;
- (BOOL(^)(BOOL(^)(id)))        f_any;
- (id (^)(BOOL(^)(id)))         f_first;

- (NSString*(^)(NSString*))     f_join;
- (NSDictionary*)               f_dict;

- (NSSet*)                      f_flatten;

@end

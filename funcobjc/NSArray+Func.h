//
//  NSArray+Func.h
//  funcobjc
//
//  Created by Alexander Smirnov on 06/06/16.
//  Copyright © 2016 Alexander Smirnov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Func)

- (NSArray*(^)(id(^)(id))) f_map;
- (NSArray*(^)(BOOL(^)(id))) f_filter;
- (id(^)(id, id(^)(id,id))) f_reduce;

- (NSDictionary*) f_dict;
- (NSString*(^)(NSString*)) f_join;

@end

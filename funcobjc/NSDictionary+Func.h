//
//  NSDictionary+Func.h
//  funcobjc
//
//  Created by Alexander Smirnov on 06/06/16.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Func)

- (NSDictionary*(^)(NSDictionary*(^)(id,id))) f_map;
- (NSDictionary*(^)(BOOL(^)(id,id)))          f_filter;
- (id(^)(id, id(^)(id,id,id)))                f_reduce;

@end

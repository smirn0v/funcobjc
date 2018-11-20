//
//  FuncShortcuts.h
//  funcobjc
//
//  Created by Alexander Smirnov on 07/06/16.
//  Copyright © 2016 Alexander Smirnov. All rights reserved.
//

NS_ASSUME_NONNULL_BEGIN

typedef _Nonnull id(^f_map_block)(id);
typedef _Nonnull id(^f_reduce_block)(id,id(^)(id,id));
typedef BOOL(^f_predicate_block)(id);
typedef BOOL(^f_equal_block)(id,id);

#pragma mark - General

f_predicate_block f_not(f_predicate_block predicate);
f_equal_block f_equal(void);

#pragma mark - NSString

f_map_block f_uppercase(void);

#pragma mark - NSNumber

f_map_block f_inc(void);

NS_ASSUME_NONNULL_END

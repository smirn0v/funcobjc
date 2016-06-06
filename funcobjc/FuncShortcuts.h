//
//  FuncShortcuts.h
//  funcobjc
//
//  Created by Alexander Smirnov on 07/06/16.
//  Copyright © 2016 Alexander Smirnov. All rights reserved.
//

typedef id(^func_map_block)(id);
typedef id(^func_reduce_block)(id,id(^)(id,id));

#pragma mark - NSString

func_map_block func_uppercase();

#pragma mark - NSNumber

func_map_block func_inc();
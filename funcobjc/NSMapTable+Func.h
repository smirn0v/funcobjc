//
//  NSMapTable+Func.h
//  MRMail
//
//  Created by Nikolay Morev on 03/11/2017.
//  Copyright © 2017 Mail.Ru. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMapTable<KeyType, ObjectType> (Func)

- (void(^)(void(^NS_NOESCAPE)(KeyType, ObjectType)))f_each;

/**
 Modifies MapTable in-place and returns self for chaining.
 */
- (NSMapTable<KeyType, ObjectType> *(^)(BOOL(^NS_NOESCAPE)(KeyType, ObjectType)))f_filter;

- (NSHashTable<KeyType> *(^)(BOOL(^NS_NOESCAPE)(KeyType, ObjectType)))f_filteredKeys;

- (id _Nullable (^)(id _Nullable, id _Nullable (^NS_NOESCAPE)(id _Nullable, KeyType, ObjectType)))f_reduce;

@end

NS_ASSUME_NONNULL_END

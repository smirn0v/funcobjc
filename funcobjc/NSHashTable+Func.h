//
//  NSHashTable+Func.h
//  MRMail
//
//  Created by Nikolay Morev on 03/11/2017.
//  Copyright © 2017 Mail.Ru. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSHashTable<ObjectType> (Func)

- (void(^)(void(^NS_NOESCAPE)(ObjectType)))f_each;

@end

NS_ASSUME_NONNULL_END

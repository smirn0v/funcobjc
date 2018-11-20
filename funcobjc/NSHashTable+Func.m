//
//  NSHashTable+Func.m
//  MRMail
//
//  Created by Nikolay Morev on 03/11/2017.
//  Copyright © 2017 Mail.Ru. All rights reserved.
//

#import "NSHashTable+Func.h"

@implementation NSHashTable (Func)

- (void (^)(NS_NOESCAPE void (^ _Nonnull)(id _Nonnull)))f_each {
    return ^(void (^ _Nonnull action)(id _Nonnull)) {
        for (id value in self) {
            action(value);
        }
    };
}

@end

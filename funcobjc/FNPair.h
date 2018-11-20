//
//  FNPair.h
//  MRMail
//
//  Created by Evgeniy Yurtaev on 20/04/2017.
//  Copyright © 2017 Mail.Ru. All rights reserved.
//

#import <Foundation/Foundation.h>

#define f_pair(__first, __second) [[FNPair<typeof(__first), typeof(__second)> alloc] initWithFirst:(__first) second:(__second)]

@interface FNPair<__covariant FirstType, __covariant SecondType> : NSObject

@property (strong, nonatomic, readonly) FirstType first;

@property (strong, nonatomic, readonly) SecondType second;

- (instancetype)initWithFirst:(FirstType)first second:(SecondType)second NS_DESIGNATED_INITIALIZER;

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

@end


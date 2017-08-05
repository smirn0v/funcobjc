//
//  FNPair.m
//
//  Created by Evgeniy Yurtaev on 20/04/2017.
//

#import "FNPair.h"

@implementation FNPair

- (instancetype)initWithFirst:(id)first second:(id)second {
    self = [super init];
    if (self) {
        _first = first;
        _second = second;
    }
    return self;
}

- (NSUInteger)hash {
    NSUInteger hash = [self.first hash];
    hash = hash * 31u + [self.second hash];

    return hash;
}

- (BOOL)isEqual:(id)object {
    if (![object isKindOfClass:[FNPair class]]) {
        return NO;
    }
    FNPair *pair = object;
    BOOL isEqual = (self.first == pair.first || [self.first isEqual:pair.first]);
    isEqual = isEqual && (self.second == pair.second || [self.second isEqual:pair.second]);

    return isEqual;
}

@end

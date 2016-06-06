//
//  NSDictionaryFuncTests.m
//  funcobjc
//
//  Created by Alexander Smirnov on 07/06/16.
//  Copyright © 2016 Alexander Smirnov. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FuncObjc.h"

@interface NSDictionaryFuncTests : XCTestCase

@end

@implementation NSDictionaryFuncTests

- (void)testMapWithGaps {
    id result = @{@"a": @(1), @"b": @(2)}.f_map(^id(id key, id value) { if([value isEqual:@2]) {return @{key: value}; } return nil; });
    id expected = @{@"b": @(2)};
    
    XCTAssertEqualObjects(result, expected);
}

- (void)testFilterAll {
    id result = @{@"a": @(1)}.f_filter(^BOOL(id key, id value) {return NO;});
    id expected = @{};
    
    XCTAssertEqualObjects(result, expected);
}

- (void)testFilterPredicate {
    id result = @{@"a": @(1), @"b": @(2)}.f_filter(^BOOL(id key, NSNumber* value) {return value.integerValue<2;});
    id expected = @{@"a": @(1)};
    
    XCTAssertEqualObjects(result, expected);
}

- (void)testReduceSumValues {
    id result = @{@"a": @(1), @"b": @(2)}.f_reduce(@(0),^id(NSNumber* initial, id key, NSNumber* value) { return @(initial.integerValue + value.integerValue);});
    id expected = @3;
    
    XCTAssertEqualObjects(result, expected);
}


@end

//
//  NSArrayFuncTests.m
//  funcobjc
//
//  Created by Alexander Smirnov on 06/06/16.
//  Copyright © 2016 Alexander Smirnov. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FuncObjc.h"

@interface NSArrayFuncTests : XCTestCase

@end

@implementation NSArrayFuncTests

- (void)testFilterEmpty {
    XCTAssertEqualObjects(@[].f_filter(^BOOL(id el){return YES;}), @[]);
}

- (void)testFilterNumberBiggerThan {
    id result = @[@1,@2,@3,@4].f_filter(^BOOL(NSNumber* el){return el.intValue > 2;});
    id expected = @[@3,@4];
    XCTAssertEqualObjects(result, expected);
}

- (void)testMapIncrement {
    id result = @[@1,@2,@3,@4].f_map(^id(NSNumber* el){ return @(el.intValue + 1);});
    id expected = @[@2,@3,@4,@5];
    XCTAssertEqualObjects(result, expected);
}

- (void)testReduceGetDictionary {
    id result = @[@"Some", @"Another"].f_reduce(@{}.mutableCopy,^id(NSMutableDictionary* initial, NSString* el) {
        return ({ initial[el] = @(el.length); initial; });
    });
    id expected = @{@"Some": @(4), @"Another": @(7)};
    XCTAssertEqualObjects(result, expected);
}

- (void)testDict {
    id result = @[@1,@2].f_dict;
    id expected = @{@1:@1, @2:@2};
    XCTAssertEqualObjects(result, expected);
}

- (void)testJoin {
    id result = @[@1, @2, @3].f_join(@",");
    id expected = @"1,2,3";
    XCTAssertEqualObjects(result, expected);
}

- (void)testNil {
    NSArray *array = nil;
    XCTAssertEqualObjects(f_(array).f_filter(^BOOL(id el){return YES;}), @[]);
}

@end

//
//  FRangeTests.m
//  funcobjc
//
//  Created by Alexander Smirnov on 21/06/16.
//

#import <XCTest/XCTest.h>
#import "FuncObjc.h"

@interface FRangeTests : XCTestCase

@end

@implementation FRangeTests

- (void)testZeroRange {
    XCTAssertEqualObjects(f_range(0), @[]);
}

- (void)testSimpleRange {
    NSArray *expected = @[@5,@6,@7,@8];
    XCTAssertEqualObjects(f_range(5,4), expected);
}

@end

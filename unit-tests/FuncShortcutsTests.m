//
//  FuncShortcutsTests.m
//  funcobjc
//
//  Created by Alexander Smirnov on 07/06/16.
//

#import <XCTest/XCTest.h>
#import "FuncObjc.h"

@interface FuncShortcutsTests : XCTestCase

@end

@implementation FuncShortcutsTests

- (void)testUppercase {
    id result = @[@"a", @"b"].f_map(func_uppercase());
    id expected = @[@"A", @"B"];
    
    XCTAssertEqualObjects(result, expected);
}

- (void)testInc {
    id result = @[@1, @2].f_map(func_inc());
    id expected = @[@2, @3];
    
    XCTAssertEqualObjects(result, expected);
}

@end

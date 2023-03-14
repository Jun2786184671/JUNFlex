//
//  JUNItemBuilderTest.m
//  JUNFlex_Tests
//
//  Created by Jun Ma on 2023/3/7.
//  Copyright © 2023 Jun Ma. All rights reserved.
//

#import "JUNBuilderTest.h"

@interface JUNItemBuilderTest : JUNBuilderTest

@end

@implementation JUNItemBuilderTest

JUN_BUILDER_TEST
- (UIView *)build {
    return
    @Item
    .ID(@"hello world")
    .size(@300)
    .border(@"0xff0000", @10)
    .radius(@10)
    .color([UIColor colorWithRed:0.1 green:0.5 blue:1.0 alpha:0.6])
    .alpha(@0.4)
    .text(@"hello")
    .action(self, @selector(testPerformanceExample))
    .align(@1, @1)
    .EOB;
}

@end

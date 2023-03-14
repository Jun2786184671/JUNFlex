//
//  JUNJSONSerializeTest.m
//  JUNFlex_Tests
//
//  Created by Jun Ma on 2023/3/7.
//  Copyright © 2023 Jun Ma. All rights reserved.
//

#import "JUNBuilderTest.h"

@interface JUNSerializerTest : JUNBuilderTest

@end

@implementation JUNSerializerTest

JUN_BUILDER_TEST
- (UIView *)build {
    return
    @Src(@"test.json");
}

@end

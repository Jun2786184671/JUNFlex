//
//  JUNStackBuilderTest.m
//  JUNFlex_Tests
//
//  Created by Jun Ma on 2023/3/7.
//  Copyright © 2023 Jun Ma. All rights reserved.
//

#import "JUNBuilderTest.h"

@interface JUNStackBuilderTest : JUNBuilderTest

@end

@implementation JUNStackBuilderTest

JUN_BUILDER_TEST
- (UIView *)build {
    return
    @VStack
    .size(@260, @340)
    .radius(@8)
    .maskBounds(@"true")
    .color(UIColor.whiteColor)
    .border(@"#cccccc", @1)
    .align(@"center")
    .children(@[
        @Auto
        .image(@"test-image1")
        .width(@"min")
        .height(@80),
        
        @Padding
        .size(@"max", @"max")
        .left(@16)
        .right(@16)
        .bottom(@8)
        .child(
            @VStack
            .align(@-1)
            .children(@[
                @Auto
                .width(@"min")
                .text(@"Hello world", @"#333333", @"20"),

                @Auto
                .width(@"min")
                .text(
                    @"This is a welcome message.",
                    @"#666666",
                    @16
                ),

                @Auto
                .radius(@"8")
                .color(@"#999999")
                .text(@"Confirm"),

                @Auto
                .radius(@8)
                .border(@1, UIColor.redColor)
                .text(@"Close", UIColor.redColor),

                @Auto
                .radius(@8)
                .color(UIColor.blueColor)
                .text(@"Other"),
                
                @Src(@"test.json")
                .color(UIColor.systemPinkColor),
            ])
        ),
    ]);
}

@end

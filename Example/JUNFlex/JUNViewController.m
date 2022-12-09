//
//  JUNAppController2.m
//  JUNFlex_Example
//
//  Created by Jun Ma on 2022/12/9.
//  Copyright © 2022 Jun Ma. All rights reserved.
//

#import "JUNViewController.h"

@interface JUNViewController ()

@end

@implementation JUNViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.jun_layout(@"test.json");
    [self.view addSubview:
//        [self testCreateLabel]
//        [self testCreateButton]
//        [self testCreateImage]
//        [self testCreateHStack]
//        [self testCreateVStack]
//        [self testCreateZStack]
        [self testCreateNestedStack]
//        [self testCreatePadding]
//        [self testCreateList]
    ];
//    UIView *res = self.view.jun_query0(@"hello");
}

- (UIView *)testCreateLabel {
    return
    JUNFlex.Item
    .text(@"hello world", 40, UIColor.blackColor)
    .EOB;
}

- (UIView *)testCreateButton {
    return
    JUNFlex.Item
    .width(100)
    .height(44)
    .radius(10)
    .color(UIColor.whiteColor)
    .border(3, UIColor.blueColor)
    .text(@"Click me!", 20, UIColor.blueColor)
    .onTap(self, @selector(buttonOnClick))
    .EOB;
}

- (UIView *)testCreateImage {
    return
    JUNFlex.Item
    .size(250, 250)
    .image(@"test-image3.jpeg")
    .EOB;
}

- (UIView *)testCreateHStack {
    return
//    JUNFlex.Hstack
//    .children(@[
//        JUNFlex.Item
//        .width(100)
//        .height(200)
//        .image(@"test-image.jpg"),
//        JUNFlex.Item
//        .height(30)
//        .text(@"hello world", 20, UIColor.blueColor),
//        UISwitch.new,
//    ]);
    JUNFlex.Hstack
    .children(@[
        JUNFlex.Item
        .height(30)
        .color(UIColor.cyanColor)
        .text(@"hello world", 20, UIColor.blackColor),

        JUNFlex.Item
        .size(100, 100)
        .image(@"test-image3.jpeg"),

        JUNFlex.Item
        .width(80)
        .height(44)
        .radius(10)
        .color(UIColor.whiteColor)
        .border(3, UIColor.blueColor)
        .text(@"Click me!", 16, UIColor.blueColor)
        .onTap(self, @selector(buttonOnClick:)),
    ]);
}

- (UIView *)testCreateVStack {
    return
//    JUNFlex.Vstack
//    .children(@[
//        JUNFlex.Item
//        .width(100)
//        .height(200)
//        .image(@"test-image.jpg"),
//        JUNFlex.Item
//        .height(30)
//        .text(@"hello world", 20, UIColor.blueColor),
//        UISwitch.new,
//        [self testCreateHStack],
//    ]);
    JUNFlex.Vstack
    .align(-1 /*主轴对齐*/, -1 /*交叉轴对齐*/)
    .children(@[
        JUNFlex.Item
        .width(100)
        .color(UIColor.cyanColor)
        .text(@"hello world", 20, UIColor.blackColor),

        JUNFlex.Item
        .size(100, 100)
        .image(@"test-image3.jpeg"),

        [[UISwitch alloc] init],  // 任何的UIView都能被加到stack的children里
    ]);
}

- (UIView *)testCreateZStack {
    return
//    JUNFlex.Zstack
//    .size(100, 100)
//    .align(-1, -1)
//    .children(@[
//        JUNFlex.Item
//        .width(100)
//        .height(200)
//        .image(@"test-image.jpg"),
//        JUNFlex.Item
//        .height(30)
//        .text(@"hello world", 20, UIColor.blueColor),
//        UISwitch.new,
////        [self testCreateVStack],
//    ]);
    JUNFlex.Zstack
//    .align(-1, -1) // 靠最左上方对齐
    .children(@[
        JUNFlex.Item
        .size(200, 200)
        .image(@"test-image3.jpeg"),
        
        JUNFlex.Item
        .width(150)
        .height(80)
        .color(UIColor.cyanColor)
        .text(@"hello world", 30, UIColor.blackColor),

        [[UISwitch alloc] init],  // 任何的UIView都能被加到stack的children里
    ]);
}

- (UIView *)testCreateNestedStack {
    return
    JUNFlex.Vstack
    .align(-1, 0)
    .children(@[
        JUNFlex.Hstack
        .children(@[
            JUNFlex.Item
            .height(30)
            .color(UIColor.cyanColor)
            .text(@"hello world", 20, UIColor.blackColor),

             JUNFlex.Item
            .size(100, 100)
            .image(@"test-image3.jpeg"),

            JUNFlex.Item
            .width(80)
            .height(44)
            .radius(10)
            .color(UIColor.whiteColor)
            .border(3, UIColor.blueColor)
            .text(@"Click me!", 16, UIColor.blueColor)
            .onTap(self, @selector(buttonOnClick)),
        ]),

        JUNFlex.Zstack
        .size(200, 200)
        .align(-1, -1)
        .children(@[
            JUNFlex.Item
            .image(@"test-image3.jpeg"),

            JUNFlex.Item
            .width(150)
            .height(80)
            .color(UIColor.cyanColor)
            .text(@"hello world", 30, UIColor.blackColor),

            [[UISwitch alloc] init],
        ]),

        [[UISwitch alloc] init],  // 任何的UIView都能被加到stack的children里
    ]);
}

- (UIView *)testCreatePadding {
    return
    JUNFlex.Padding
    .top(10)
    .left(20)
    .bottom(30)
    .right(40)
    .child(
        [self testCreateVStack]
    );
}

- (UIView *)testCreateList {
    return
    JUNFlex.List
    .size(300, 500)
    .count(100, ^id _Nonnull(NSUInteger i) {
        return [self testCreateZStack];
    });
}

- (void)buttonOnClick {
    NSLog(@"%s", __func__);
}

@end

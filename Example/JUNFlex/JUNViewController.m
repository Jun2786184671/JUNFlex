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
    self.jun_layout(@"test.json");
    [self.view addSubview:
        [self testCreateLabel]
//        [self testCreateButton]
//        [self testCreateImage]
//        [self testCreateHStack]
//        [self testCreateVStack]
//        [self testCreateZStack]
//        [self testCreateNestedStack]
//        [self testCreatePadding]
//        [self testCreateList]
    ];
//    UIView *res = self.view.jun_query0(@"hello");
}

- (UIView *)testCreateLabel {
    return
    [JUNFlex item]
    .text(@"hello world",
          [UIFont systemFontOfSize:40],
          UIColor.blackColor)
    .EOB;
}

- (UIView *)testCreateButton {
    return
    [JUNFlex item]
    .width(100)
    .height(44)
    .radius(10)
    .color(UIColor.whiteColor)
    .border(3, UIColor.blueColor)
    .text(@"Click me!", [UIFont systemFontOfSize:20], UIColor.blueColor)
    .onTap(self, @selector(buttonOnClick))
    .EOB;
}

- (UIView *)testCreateImage {
    return
    [JUNFlex item]
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
    [JUNFlex hstack]
    .children(@[
        [JUNFlex item]
        .height(30)
        .color(UIColor.cyanColor)
        .text(@"hello world", [UIFont systemFontOfSize:20], UIColor.blackColor),

        [JUNFlex item]
        .size(100, 100)
        .image(@"test-image3.jpeg"),

        [JUNFlex item]
        .width(80)
        .height(44)
        .radius(10)
        .color(UIColor.whiteColor)
        .border(3, UIColor.blueColor)
        .text(@"Click me!", [UIFont systemFontOfSize:16], UIColor.blueColor)
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
    JUNFlex.vstack
    .align(-1 /*主轴对齐*/, -1 /*交叉轴对齐*/)
    .children(@[
        JUNFlex.item
        .width(100)
        .color(UIColor.cyanColor)
        .text(@"hello world", [UIFont systemFontOfSize:20], UIColor.blackColor),

        JUNFlex.item
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
    JUNFlex.zstack
//    .align(-1, -1) // 靠最左上方对齐
    .children(@[
        JUNFlex.item
        .size(200, 200)
        .image(@"test-image3.jpeg"),
        
        JUNFlex.item
        .width(150)
        .height(80)
        .color(UIColor.cyanColor)
        .text(@"hello world", [UIFont systemFontOfSize:30], UIColor.blackColor),

        [[UISwitch alloc] init],  // 任何的UIView都能被加到stack的children里
    ]);
}

- (UIView *)testCreateNestedStack {
    return
    JUNFlex.vstack
    .align(-1, 0)
    .children(@[
        JUNFlex.hstack
        .children(@[
            JUNFlex.item
            .height(30)
            .color(UIColor.cyanColor)
            .text(@"hello world", [UIFont systemFontOfSize:20], UIColor.blackColor),

             JUNFlex.item
            .size(100, 100)
            .image(@"test-image3.jpeg"),

            JUNFlex.item
            .width(80)
            .height(44)
            .radius(10)
            .color(UIColor.whiteColor)
            .border(3, UIColor.blueColor)
            .text(@"Click me!", [UIFont systemFontOfSize:16], UIColor.blueColor)
            .onTap(self, @selector(buttonOnClick)),
        ]),

        JUNFlex.zstack
        .size(200, 200)
        .align(-1, -1)
        .children(@[
            JUNFlex.item
            .image(@"test-image3.jpeg"),

            JUNFlex.item
            .width(150)
            .height(80)
            .color(UIColor.cyanColor)
            .text(@"hello world", [UIFont systemFontOfSize:30], UIColor.blackColor),

            [[UISwitch alloc] init],
        ]),

        [[UISwitch alloc] init],  // 任何的UIView都能被加到stack的children里
    ]);
}

- (UIView *)testCreatePadding {
    return
//    JUNFlex.padding
//    .top(10)
//    .left(20)
//    .bottom(30)
//    .right(40)
//    .child(
//        [self testCreateVStack]
//    );
    JUNFlex.padding
    .top(10).left(20).bottom(30).right(40)
    .radius(20)
    .color(UIColor.cyanColor)
    .border(4, UIColor.blueColor)
    .child( // 把需要被装饰的view包裹在child里
        JUNFlex.item
        .size(100, 100)
        .image(@"test-image3.jpeg")
    );
}

- (UIView *)testCreateList {
    return
    JUNFlex.list
    .horizontal(false)
    .size(500, 500)
    .lineSpacing(20)
    .count(100, ^id (NSUInteger i) {
        return
        JUNFlex.zstack
        .size(100, 100)
        .children(@[
            JUNFlex.padding
            .radius(20)
            .maskBounds(true)
            .child(
                JUNFlex.item
                .alpha(0.6)
                .image(@"test-image3.jpeg")
            ),
            
            JUNFlex.vstack
            .height(80)
            .children(@[
                JUNFlex.item
                .text([NSString stringWithFormat:@"第%ld个", i], [UIFont systemFontOfSize:20], UIColor.blackColor),
                
                JUNFlex.item
                .text(@"Click me!", [UIFont systemFontOfSize:18], UIColor.blueColor)
                .onTap(self, @selector(buttonOnClick)),
            ]),
        ]);
    });
}

- (void)buttonOnClick {
    NSLog(@"%s", __func__);
}

@end

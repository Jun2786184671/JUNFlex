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
//        [self testCreateHStack]
//        [self testCreateVStack]
//        [self testCreateZStack]
//        [self testCreatePadding]
        [self testCreateList]
    ];
    UIView *res = self.view.jun_query0(@"hello");
}

- (UIView *)testCreateHStack {
    return
    JUNFlex.Hstack
    .children(@[
        JUNFlex.Item
        .width(100)
        .height(200)
        .image(@"test-image.jpg"),
        JUNFlex.Item
        .height(30)
        .text(@"hello world", 20, UIColor.blueColor),
        UISwitch.new,
    ]);
}

- (UIView *)testCreateVStack {
    return
    JUNFlex.Vstack
    .children(@[
        JUNFlex.Item
        .width(100)
        .height(200)
        .image(@"test-image.jpg"),
        JUNFlex.Item
        .height(30)
        .text(@"hello world", 20, UIColor.blueColor),
        UISwitch.new,
        [self testCreateHStack],
    ]);
}

- (UIView *)testCreateZStack {
    return
    JUNFlex.Zstack
    .size(100, 100)
    .align(-1, -1)
    .children(@[
        JUNFlex.Item
        .width(100)
        .height(200)
        .image(@"test-image.jpg"),
        JUNFlex.Item
        .height(30)
        .text(@"hello world", 20, UIColor.blueColor),
        UISwitch.new,
//        [self testCreateVStack],
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

@end

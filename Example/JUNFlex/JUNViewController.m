//
//  JUNViewController.m
//  JUNFlex
//
//  Created by Jun Ma on 11/26/2022.
//  Copyright (c) 2022 Jun Ma. All rights reserved.
//

#import "JUNViewController.h"
#import <JUNFlex/JUNFlex.h>
#import <JUNTableView/UITableView+JUNex.h>

@interface JUNViewController ()

@end

@implementation JUNViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.view.translatesAutoresizingMaskIntoConstraints = false;
	// Do any additional setup after loading the view, typically from a nib.
    UIView *stack =
//    [self testCreateHStack];
    [self testCreateVStack];
//    [self createItem5];
    stack.frame = self.view.bounds;
    [self.view addSubview:stack];
}

- (UIView *)testCreateHStack {
    return
    Horizontal.properties(@{
        kJUNFlexAlignment : @(JUNFlexAlignmentCenter),
        kJUNFlexLinearArrangement : @(JUNFlexLinearArrangementSpaceBetween),
        kJUNFlexInsetsAll : @(10),
    }).children(@[
        [self createItem1],
        [self createItem2],
        [self createItem3],
    ]);
}

- (UIView *)testCreateVStack {
    return
    Vertical.properties(@{
        kJUNFlexAlignment : @(JUNFlexAlignmentCenter),
        kJUNFlexLinearArrangement : @(JUNFlexLinearArrangementSpaceBetween),
        kJUNFlexInsetsAll : @(10),
    }).children(@[
        [self createItem1],
        [self createItem2],
        [self createItem3],
        Horizontal.children(@[
            [self createItem1],
            [self createItem2],
            [self createItem3],
        ]),
        [self createItem5],
        Horizontal.properties(@{
            kJUNFlexAlignment : @(1),
            kJUNFlexLinearArrangement : @(JUNFlexLinearArrangementSpaceEqual),
        }).children(@[
            [self createItem1],
            [self createItem2],
            [self createItem4],
        ]),
    ]);
}

- (UIView *)createItem1 {
    UIButton *aButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [aButton setTitle:@"aButton" forState:UIControlStateNormal];
    [aButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    return aButton;
}

- (UIView *)createItem2 {
    UISwitch *aSwitch = [[UISwitch alloc] init];
    return aSwitch;
}

- (UIView *)createItem3 {
    UILabel *aLabel = [[UILabel alloc] init];
    aLabel.text = @"aLabel";
    aLabel.textColor = [UIColor blackColor];
    return aLabel;
}

- (UIView *)createItem4 {
    UIView *aView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 80)];
    aView.backgroundColor = [UIColor orangeColor];
    return aView;
}

- (UIView *)createItem5 {
    UITableView *aTableView = [UITableView jun_tableViewWithItemCount:10 itemBuilder:^UIView * _Nonnull(NSUInteger index) {
        return Horizontal.properties(@{
            kJUNFlexInsets : [NSValue valueWithUIEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 10)]
        }).children(@[
            [self createItem1],
            [self createItem2],
            [self createItem3],
        ]);
    }];
    aTableView.rowHeight = 100;
    aTableView.frame = CGRectMake(0, 0, 0, 200);
    aTableView.jun_itemSpacing = 30;
    return aTableView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

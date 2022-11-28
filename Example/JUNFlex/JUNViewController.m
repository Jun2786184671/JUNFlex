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
#import <JUNCollectionView/UICollectionView+JUNex.h>

@interface JUNViewController ()

@end

@implementation JUNViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    UIView *stack =
//    [self testCreateHStack];
    [self testCreateVStack];
//    [self testCreateZStack];
//    [self createItem5];
    stack.frame = self.view.bounds;
    [self.view addSubview:stack];
}

- (UIView *)testCreateHStack {
    return
    Horizontal.properties(@{
        jun_alignment(JUNStackAlignmentCrossAxisCenter | JUNStackAlignmentMainAxisCenter),
        jun_insetLeft(30),
    }).children(@[
        [self createItem1],
        [self createItem2],
        [self createItem3],
        [self createItem1],
        [self createItem2],
        [self createItem1],
        [self createItem2],
    ]);
}

- (UIView *)testCreateVStack {
    return
    Vertical.properties(@{
        jun_alignment(JUNStackAlignmentCrossAxisCenter),
        jun_insetAll(30)
    }).children(@[

        [self createItem1],
        [self createItem2],
        [self createItem3],
        [self createItem4],
        [self createItem6],

//        Horizontal.children(@[
//            [self createItem1],
//            [self createItem2],
//            [self createItem3],
//        ]),
//
//        Horizontal.properties(@{
//            kJUNStackAlignment : @(JUNStackAlignmentCrossAxisMin),
//        }).children(@[
//            [self createItem1],
//            [self createItem2],
//            [self createItem3],
//            [self createItem4],
//        ]),
    ]);
}

- (UIView *)testCreateZStack {
    return
    Stack.properties(@{
        jun_alignment(JUNStackAlignmentMainAxisMin | JUNStackAlignmentCrossAxisMin)
    }).children(@[
        [self createItem4],
        [self createItem6],
        [self createItem7],
        [self createItem8],
        Stack.properties(@{
            jun_alignment(JUNStackAlignmentMainAxisMax | JUNStackAlignmentCrossAxisCenter)
        }).children(@[
            [self createItem10],
            [self createItem5],
//            [self createItem6],
//            [self createItem7],
//            [self createItem8],
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
    UIView *aView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 420, 420)];
    aView.backgroundColor = [UIColor orangeColor];
    return aView;
}

- (UIView *)createItem5 {
    UITableView *aTableView =

    [UITableView jun_tableViewWithItemCount:10 itemBuilder:^UIView * _Nonnull(NSUInteger index) {
        return Horizontal.properties(@{
            kJUNStackInsets : [NSValue valueWithUIEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 10)]
        }).children(@[
            [self createItem1],
            [self createItem2],
            [self createItem3],
        ]);
    }];
    aTableView.rowHeight = 100;
//    aTableView.frame = CGRectMake(0, 0, 0, 200);
    aTableView.jun_itemSpacing = 30;
    return aTableView;
}

- (UIView *)createItem6 {
    UIView *aView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    aView.backgroundColor = [UIColor redColor];
    return aView;
}

- (UIView *)createItem7 {
    UIView *aView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 280, 280)];
    aView.backgroundColor = [UIColor greenColor];
    return aView;
}

- (UIView *)createItem8 {
    UIView *aView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 260, 260)];
    aView.backgroundColor = [UIColor blueColor];
    return aView;
}

- (UIView *)createItem10 {
    UIView *aView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 220, 220)];
    aView.backgroundColor = [UIColor yellowColor];
    return aView;
}

- (void)buttonClicked {
    NSLog(@"%s", __func__);
}

- (UIView *)createItem9 {
    UICollectionView *aCollectionView = [UICollectionView jun_collectionViewWithItemCount:100 itemBuilder:^UIView * _Nonnull(NSUInteger index) {
        unsigned int type = index % 4;
        switch (type) {
            case 0: {
                UILabel *aLabel = [[UILabel alloc] init];
                aLabel.textColor = [UIColor blackColor];
                aLabel.text = [NSString stringWithFormat:@"label %lu", index];
                return aLabel;
            }
            case 1: {
                UIButton *aButton = [UIButton buttonWithType:UIButtonTypeCustom];
                [aButton setTitle:[NSString stringWithFormat:@"button %lu", index] forState:UIControlStateNormal];
                [aButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
                return aButton;
            }
            case 2: {
                UISwitch *aSwitch = [[UISwitch alloc] init];
                return aSwitch;
            }
            default: {
                UIView *aView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
                aView.backgroundColor = [UIColor orangeColor];
                return aView;
            }
        }
    } direction:UICollectionViewScrollDirectionHorizontal];
    aCollectionView.frame = CGRectMake(0, 0, 0, 200);
    aCollectionView.jun_minimumLineSpacing = 8;
    return aCollectionView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

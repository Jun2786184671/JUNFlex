////
////  ViewController.m
////  JUNFlex_Example
////
////  Created by Jun Ma on 2022/11/29.
////  Copyright © 2022 Jun Ma. All rights reserved.
////
//
//#import "ViewController.h"
//#import <JUNFlex/JUNFlex.h>
//#import <JUNTableView/UITableView+JUNex.h>
//#import <JUNCollectionView/UICollectionView+JUNex.h>
//
//@interface ViewController ()
//
//@end
//
//@implementation ViewController
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view.
////    self.view.translatesAutoresizingMaskIntoConstraints = false;
//    [self.view addSubview:[self createTest2]];
//}
//
//- (UIView *)createTest2 {
////    return
////    Item.color(0x0000ff00).fin;
//    return
//    Hstack.align.main(1).cross(0).children(@[
//        [UISwitch new],
//        [self createTableview],
//        [self createCollection],
//        Vstack.children(@[
//            Item
//                .color(0xff0000ff)
//                .radius(20)
//                .width(100).fin,
//            Item
//                .text(@"hello world", 20, 0x0)
//                .width(100)
//                .height(100).fin,
//            
//            Item.image(@"test-image").width(80).height(80).fin,
//            Item.color(0xff0000ff).radius(20).width(100).fin,
//            Item.text(@"hello world", 20, 0x0).width(100).height(100).fin,
//            Item.color(0xff0000ff).radius(20).width(100).fin,
//            Item.text(@"hello world", 20, 0x0).width(100).height(100).fin,
//            
//            Zstack.align.main(-1).cross(-1).children(@[
//                
//                Item.color(0xff0000ff).width(100).height(100).fin,
//                
//                Padding.l(20).r(10).child(
//                    Item.color(0x00ff00ff).width(80).height(80).fin
//                ),
//                Item.color(0x0000ffff).width(60).height(60).fin,
//                Item.color(0xffff00ff).width(40).height(40).fin,
//            ]),
//        ]),
//    ]);
//}
//
//- (UIView *)createTableview {
//    UITableView *tableview =
//    [UITableView jun_tableViewWithItemCount:100 itemBuilder:^UIView * _Nonnull(NSUInteger index) {
//        int type = index % 3;
//        switch (type) {
//            case 0:
//                return Item.text(@"click me!!!", 20, 0x0).onTap(self, @selector(buttonClicked)).fin;
//            case 1:
//                return [UISwitch new];
//            default:
//                return Item.height(30).image(@"test-image").height(200).fin;
//        }
//    }];
//    tableview.frame = CGRectMake(0, 0, 100, 0);
//    tableview.jun_alignment = JUNTableViewItemAlignmentTrailing;
//    return tableview;
//}
//
//- (UIView *)createTest {
////    return
////    Padding.all(20).child(
////        Item.color(0x0000ff00).width(100).height(100).fin
////                        );
//    
//    return
//    Vstack.align.cross(0).main(0)
//    .children(@[
//        Item.text(@"hello world", 20, 0x0).fin,
//        [UISwitch new],
//        
//        [self createTable],
//        
//        Hstack.align.cross(0).children(@[
//            Item.text(@"hello world", 20, 0x0).fin,
//            [UISwitch new],
//
//            Zstack.align.cross(1).main(1)
//            .children(@[
//                Item.color(0xff000000).width(100).height(100).fin,
//                Item.color(0x00ff0000).width(80).height(80).fin,
//            ]),
//
//            Padding.l(20).child(
//            Item.color(0x0000ff00).width(60).fin
//            ),
//           
//            
//            
//            Item.text(@"hello world", 20, 0x0).fin,
//            [UISwitch new],
//            
//            
//        ]),
//        
//        Item.height(100).image(@"test-image").onTap(self, @selector(buttonClicked)).fin,
//        Item.text(@"hello world", 20, 0x0).fin,
//    ]);
//}
//
//- (void)buttonClicked {
//    NSLog(@"hahaha");
//}
//
//- (UIView *)createTable {
//    UITableView *table =
//    [UITableView jun_tableViewWithItemCount:100 itemBuilder:^UIView * _Nonnull(NSUInteger index) {
//        int type = index % 3;
//        switch (type) {
//            case 0:
//                return Item.text(@"hello", 20, 0x0).fin;
//            case 1:
//                return [UISwitch new];
//            default:
//                return Item.height(30).image(@"test-image").height(200).fin;
//        }
//    }];
//    table.frame = CGRectMake(0, 0, 0, 300);
//    table.translatesAutoresizingMaskIntoConstraints = false;
//    table.jun_alignment = JUNTableViewItemAlignmentLeading;
//    table.jun_indent = 30;
////    table.rowHeight = 80;
//    return table;
//}
//
//- (UIView *)createCollection {
//    UICollectionView *collection =
//    [UICollectionView jun_collectionViewWithItemCount:100 itemBuilder:^UIView * _Nonnull(NSUInteger index) {
//        int type = index % 3;
//        switch (type) {
//            case 0:
//                return Item.text(@"hello", 20, 0x0).fin;
//            case 1:
//                return [UISwitch new];
//            default:
//                return Item.color(0x0000ffff).width(100).height(100).fin;
//        }
//    } direction:UICollectionViewScrollDirectionHorizontal];
//    collection.frame = CGRectMake(0, 0, 300, 300);
//    collection.jun_minimumInteritemSpacing = 20;
//    return collection;
//}
//
///*
//#pragma mark - Navigation
//
//// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//}
//*/
//
//@end

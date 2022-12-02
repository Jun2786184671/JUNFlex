//
//  XZAppViewController.m
//  JUNFlex_Example
//
//  Created by Jun Ma on 2022/11/29.
//  Copyright © 2022 Jun Ma. All rights reserved.
//

#import "JUNAppController.h"
#import "JUNAppModel.h"
#import <JUNFlex/$Flex.h>

@interface JUNAppController ()

@property(nonatomic, strong) JUNAppModel *appModel;

@end

@implementation JUNAppController

+ (void)load {
    // register data mapper
    $Mapper(JUNAppModel.class, ^(id $, JUNAppModel *_) {
        _.name = $[@"name"];
        _.title = $[@"text"];
        _.message = $[@"mes"];
        _.image = $[@"img"];
        _.reserveCount = [$[@"hot"] integerValue];
    });
}

// for code
- (instancetype)init {
    if (self = [super init]) {
        [self bindUI];
    }
    return self;
}

// for storyboard
- (void)awakeFromNib {
    [super awakeFromNib];
    [self bindUI];
}

- (void)bindUI3 {
    $Layout(JUNAppModel.class, ^id (JUNAppModel *_) {
        return
        $Zstack.children(@[
            $Vstack
            .children(@[
                $Item
                .size(CGSizeMake(80, 80))
                .image(_.image)
                .radius(30),
                 $Item
                 .text(_.title, 20, UIColor.blueColor)
                 .onTap(self, @selector(buttonOnTap)),
                  UISwitch.new
            ])
        ]);
    });
}

- (void)bindUI {
    $Layout(JUNAppModel.class, ^UIView *(JUNAppModel *_) {
        return
        $List
        .width(300)
        .height(500)
        .horizontal(true)
        .itemSize(CGSizeMake(80, 80))
        .alwaysBounce(true)
        .showIndicator(true)
        .count(10, ^id (NSUInteger i) {
            return
            $Vstack
            .width(300)
            .height(500)
            .children(@[
                 $Item
                 .size(CGSizeMake(80, 80))
                 .image(_.image)
                 .radius(30),
                  $Hstack
//                  .width(1000)
                  .children(@[
                    $Item
                    .text(_.title, 20, UIColor.blueColor)
                    .onTap(self, @selector(buttonOnTap)),
                     UISwitch.new
                  ]),
                 
                 $Item
                 .width(120)
                 .text(_.message, 20, UIColor.blueColor)
                 .color(UIColor.greenColor)
            ]);
        });
    });
}

- (void)bindUI2 {
    
    $Layout(JUNAppModel.class, ^(JUNAppModel *_) {
        return
        $Vstack
        .align(CGPointMake(0, 0))
        .height(852)
        .children(@[
            $Padding
            .all(2)
            .radius(30)
            .color(UIColor.lightGrayColor)
            .child(
                $Zstack
                .width(100)
                .align(CGPointMake(-1, -1))
                .children(@[
                    $Item
                    .ID(@"test")
                    .color(UIColor.orangeColor)
                    .size(CGSizeMake(100, 100))
                    .radius(30),
                    $Vstack
                    .align(CGPointMake(-1, 0))
                    .children(@[
                        $Item
                        .color(UIColor.yellowColor)
                        .width(60)
                        .radius(10)
                        .text(_.name, 20, UIColor.purpleColor),
                        $Hstack
                        .align(CGPointMake(-1, 0))
                        .children(@[
                            $Item.text(@"count", 16, UIColor.blackColor),
                            $Item.text(@(_.reserveCount).description, 16, UIColor.whiteColor),
                        ]),
                    ]),
                    $Item
                    .color(UIColor.redColor)
                    .alpha(0.6)
                    .width(20).height(20)
                    .radius(10),
                ])
            ),
            $Item
            .text(_.title, 30, UIColor.blackColor),
//            $Padding
//            .color(UIColor.cyanColor)
//            .alpha(0.6)
//            .radius(20)
//            .left(20).right(20)
//            .child(
                $Item
                .text(_.message, 40, UIColor.blueColor)
                .onTap(self, @selector(buttonOnTap)),
//            ),
            $Hstack
            .children(@[
                $Padding
//                .radius(30)
                .maskBounds(true)
                .child(
                    $Item
                    .width(200)
//                    .radius(30)
                    .height(100)
                    .image(_.image)
                ),
//                 $List
////                 .width(100)
////                 .height(400)
//                 .children(@[
//                     $Item
//                     .text(_.message, 20, UIColor.blueColor)
//                     .onTap(self, @selector(buttonOnTap)),
////                     $Item
////                         .radius(30)
////                         .height(100)
////                         .image(_.image),
//                     ^(){
//                         UISwitch *aSwitch = UISwitch.new;
//                         aSwitch.frame = CGRectMake(0, 0, 30, 30);
//                         return aSwitch;
//                     }(),
//                 ]),
            ]),
            $Padding
            .color(UIColor.systemBlueColor)
            .all(20)
            .child(
                $Padding
                .color(UIColor.systemYellowColor)
                .all(20)
                .child(
                    ^(){
                        UISwitch *aSwitch = UISwitch.new;
                        aSwitch.frame = CGRectMake(0, 0, 30, 30);
                        return aSwitch;
                    }()
                )
            ),
        ]);
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self loadData:^(id json) {
        self.appModel = JUNAppModel.$map(json);
        [self.view addSubview:self.appModel.$render];
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSArray *results = self.view.$query(@"test");
        NSLog(@"%@", results);
    });
}

- (void)buttonOnTap {
    NSLog(@"You click it!!!");
}

- (void)loadData:(void (^)(id json))completion {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        completion(@{
            @"name" : @"webox",
            @"text" : @"JUN Flex!",
            @"mes" : @"Try click me!",
            @"hot" : @666,
            @"img" : @"test-image.jpg",
        });
    });
}

@end

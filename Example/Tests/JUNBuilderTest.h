//
//  JUNBuilderTest.h
//  JUNFlex
//
//  Created by Jun Ma on 2023/3/7.
//  Copyright © 2023 Jun Ma. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <JUNFlex/JUNFlex.h>

#define JUN_BUILDER_TEST \
- (void)testBuild {\
    self.productView = [self build];\
}

@interface JUNBuilderTest : XCTestCase

@property(nonatomic, weak) UIViewController *rootVC;
@property(nonatomic, strong) UIView *productView;

- (UIView *)build;

@end

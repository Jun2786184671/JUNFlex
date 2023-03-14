//
//  JUNBuilderTest.m
//  JUNFlex_Tests
//
//  Created by Jun Ma on 2023/3/7.
//  Copyright © 2023 Jun Ma. All rights reserved.
//

#import "JUNBuilderTest.h"

@implementation JUNBuilderTest

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    NSLog(@"%@", self.productView.jun_jsonString);
    [self.rootVC.view addSubview:self.productView];
    NSParameterAssert([[NSRunLoop currentRunLoop] isEqual:[NSRunLoop mainRunLoop]]);
    [[NSRunLoop currentRunLoop] run];
}

- (UIView *)build {
    return nil;
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end

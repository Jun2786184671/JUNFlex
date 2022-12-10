//
//  UIViewController+JUNFlex.m
//  JUNFlex
//
//  Created by Jun Ma on 2022/12/9.
//

#import "UIViewController+JUNFlex.h"
#import "UIView+JUNFlex.h"

@implementation UIViewController (JUNFlex)

- (void (^)(NSString * _Nonnull))jun_layout {
    return ^(NSString *fileName) {
        self.view.jun_layout(fileName);
    };
}

@end

//
//  UIView+JUNex4Flex.m
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/28.
//

#import "UIView+JUNFlex_Private.h"
#import "JUNPadding.h"
#import "JUNItem.h"

@implementation UIView (JUNFlex_Private)

- (CGRect)jun_validateFrame {
    CGRect frame = self.frame;
    CGFloat w = frame.size.width;
    CGFloat h = frame.size.height;
    if (!w || !h) {
        [self sizeToFit];
        w = w ? w : self.frame.size.width;
        h = h ? h : self.frame.size.height;
        frame.size.width = w;
        frame.size.height = h;
        self.frame = frame;
    }
    return frame;
}

@end

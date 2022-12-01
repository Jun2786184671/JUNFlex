//
//  JUNItem.m
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/29.
//

#import "JUNItem.h"
#import "UIView+JUNex4Flex.h"

@implementation JUNItem

- (void)didMoveToWindow {
    [self jun_addDefaultConstraintsIfNeeded];
}

- (void)sizeToFit {
    if (!self.currentImage || !self.currentTitle.length) return;
    [super sizeToFit];
}

@end

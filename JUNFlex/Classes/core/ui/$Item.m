//
//  JUNItem.m
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/29.
//

#import "$Item.h"
#import "UIView+JUNex4Flex.h"

@implementation $Item

- (void)didMoveToWindow {
    [self jun_addDefaultConstraintsIfNeeded];
}

- (void)sizeToFit {
    if (!self.currentImage || !self.currentTitle.length) return;
    [super sizeToFit];
}

@end

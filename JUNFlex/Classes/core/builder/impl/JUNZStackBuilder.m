//
//  JUNZStackBuilder.m
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/28.
//

#import "JUNZStackBuilder.h"
#import "JUNStackBuilder+JUNex.h"
#import "JUNZStack.h"

@implementation JUNZStackBuilder

- (JUNStack *)_getStackWithItems:(NSArray<UIView *> *)items alignment:(JUNStackAlignment)alignment insets:(UIEdgeInsets)insets {
    return [[JUNZStack alloc] initWithItems:items alignment:alignment insets:insets];
}

@end

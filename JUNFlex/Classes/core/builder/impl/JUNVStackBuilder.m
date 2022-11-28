//
//  JUNVStackBuilder.m
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/27.
//

#import "JUNVStackBuilder.h"
#import "JUNStackBuilder+JUNex.h"
#import "JUNVStack.h"

@implementation JUNVStackBuilder

- (JUNStack *)_getStackWithItems:(NSArray<UIView *> *)items alignment:(JUNStackAlignment)alignment insets:(UIEdgeInsets)insets {
    return [[JUNVStack alloc] initWithItems:items alignment:alignment insets:insets];
}

@end

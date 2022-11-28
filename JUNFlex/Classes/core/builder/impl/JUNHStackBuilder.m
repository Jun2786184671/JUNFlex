//
//  JUNHStackBuilder.m
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/27.
//

#import "JUNHStackBuilder.h"
#import "JUNStackBuilder+JUNex.h"
#import "JUNHStack.h"

@implementation JUNHStackBuilder

- (JUNStack *)_getStackWithItems:(NSArray<UIView *> *)items alignment:(JUNStackAlignment)alignment insets:(UIEdgeInsets)insets {
    return [[JUNHStack alloc] initWithItems:items alignment:alignment insets:insets];
}

@end

//
//  JUNVStackBuilder.m
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/27.
//

#import "JUNVStackBuilder.h"
#import "JUNStackBuilder+Private.h"
#import "JUNVStack.h"

@implementation JUNVStackBuilder

- (JUNStack *)_getStackWithItems:(NSArray<UIView *> *)items alignment:(CGPoint)alignment {
    return [[JUNVStack alloc] initWithItems:items alignment:alignment];
}

@end

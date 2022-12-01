//
//  JUNHStackBuilder.m
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/27.
//

#import "JUNHStackBuilder.h"
#import "JUNStackBuilder+Private.h"
#import "JUNHStack.h"

@implementation JUNHStackBuilder

- (JUNStack *)_getStackWithItems:(NSArray<UIView *> *)items alignment:(CGPoint)alignment {
    return [[JUNHStack alloc] initWithItems:items alignment:alignment];
}

@end

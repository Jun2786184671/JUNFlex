//
//  JUNHStackBuilder.m
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/27.
//

#import "$HStackBuilder.h"
#import "JUNStackBuilder+Private.h"
#import "JUNHStack.h"

@implementation $HStackBuilder

- (JUNStack *)_getStackWithItems:(NSArray<UIView *> *)items alignment:(CGPoint)alignment {
    return [[JUNHStack alloc] initWithItems:items alignment:alignment];
}

@end

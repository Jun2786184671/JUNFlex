//
//  JUNZStackBuilder.m
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/28.
//

#import "$ZStackBuilder.h"
#import "JUNStackBuilder+Private.h"
#import "JUNZStack.h"

@implementation $ZStackBuilder

- (JUNStack *)_getStackWithItems:(NSArray<UIView *> *)items alignment:(CGPoint)alignment {
    return [[JUNZStack alloc] initWithItems:items alignment:alignment];
}

@end

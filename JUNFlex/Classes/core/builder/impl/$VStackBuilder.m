//
//  JUNVStackBuilder.m
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/27.
//

#import "$VStackBuilder.h"
#import "$StackBuilder+Private.h"
#import "$VStack.h"

@implementation $VStackBuilder


- ($Stack *)_getProductWithChildren:(NSArray<UIView *> *)items alignment:(CGPoint)alignment {
    return [[$VStack alloc] initWithItems:items alignment:alignment];
}

@end

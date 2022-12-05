//
//  JUNHStackBuilder.m
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/27.
//

#import "$HStackBuilder.h"
#import "$StackBuilder+Private.h"
#import "$HStack.h"

@implementation $HStackBuilder

- ($Stack *)_getProductWithChildren:(NSArray<UIView *> *)items mainAxisAlignment:(int)mainAxisAlignment crossAxisAlignment:(int)crossAxisAlignment {
    return [[$HStack alloc] initWithItems:items mainAxisAlignment:mainAxisAlignment crossAxisAlignment:crossAxisAlignment];
}

@end

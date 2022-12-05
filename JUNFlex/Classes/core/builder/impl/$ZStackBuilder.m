//
//  JUNZStackBuilder.m
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/28.
//

#import "$ZStackBuilder.h"
#import "$StackBuilder+Private.h"
#import "$ZStack.h"

@implementation $ZStackBuilder

- ($Stack *)_getProductWithChildren:(NSArray<UIView *> *)items mainAxisAlignment:(int)mainAxisAlignment crossAxisAlignment:(int)crossAxisAlignment {
    return [[$ZStack alloc] initWithItems:items mainAxisAlignment:mainAxisAlignment crossAxisAlignment:crossAxisAlignment];
}

@end

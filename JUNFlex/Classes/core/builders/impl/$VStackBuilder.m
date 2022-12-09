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

+ (void)load {
    [super load];
}

+ (NSString *)type {
    return @"vstack";
}

- ($Stack *)_getProductWithChildren:(NSArray<UIView *> *)items mainAxisAlignment:(int)mainAxisAlignment crossAxisAlignment:(int)crossAxisAlignment {
    return [[$VStack alloc] initWithItems:items mainAxisAlignment:mainAxisAlignment crossAxisAlignment:crossAxisAlignment];
}

@end

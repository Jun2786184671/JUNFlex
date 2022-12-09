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

+ (void)load {
    [super load];
}

+ (NSString *)type {
    return @"hstack";
}

- (JUNStack *)_getProductWithChildren:(NSArray<UIView *> *)items mainAxisAlignment:(int)mainAxisAlignment crossAxisAlignment:(int)crossAxisAlignment {
    return [[JUNHStack alloc] initWithItems:items mainAxisAlignment:mainAxisAlignment crossAxisAlignment:crossAxisAlignment];
}

@end

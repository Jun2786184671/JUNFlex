//
//  JUNZStackBuilder.m
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/28.
//

#import "JUNZStackBuilder.h"
#import "JUNStackBuilder+Private.h"
#import "JUNZStack.h"

@implementation JUNZStackBuilder

+ (void)load {
    [super load];
}

+ (NSString *)type {
    return @"zstack";
}

- (JUNStack *)_getProductWithChildren:(NSArray<UIView *> *)items mainAxisAlignment:(int)mainAxisAlignment crossAxisAlignment:(int)crossAxisAlignment {
    return [[JUNZStack alloc] initWithItems:items mainAxisAlignment:mainAxisAlignment crossAxisAlignment:crossAxisAlignment];
}

@end

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

+ (void)load {
    [super load];
}

+ (NSString *)type {
    return @"vstack";
}

- (JUNStack *)_getProductWithChildren:(NSArray<UIView *> *)items mainAxisAlignment:(int)mainAxisAlignment crossAxisAlignment:(int)crossAxisAlignment aspectRatio:(bool)aspectRatio {
    return [[JUNVStack alloc] initWithItems:items mainAxisAlignment:mainAxisAlignment crossAxisAlignment:crossAxisAlignment aspectRatio:aspectRatio];
}

@end

//
//  JUNVStackBuilder.m
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/27.
//

#import "JUNVStackBuilder.h"
#import "JUNVStack.h"
#import "JUNFlex.h"

@implementation JUNVStackBuilder

+ (instancetype)sharedInstance {
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (JUNStack *)_getStackWithItems:(NSArray<UIView *> *)items alignment:(JUNFlexAlignment)alignment arrangement:(JUNFlexLinearArrangement)arrangement insets:(UIEdgeInsets)insets {
    return [[JUNVStack alloc] initWithItems:items alignment:alignment arrangement:arrangement insets:insets];
}

@end

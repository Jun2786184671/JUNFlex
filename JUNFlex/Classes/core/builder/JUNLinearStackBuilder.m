//
//  JUNLinearStackBuilder.m
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/27.
//

#import "JUNLinearStackBuilder.h"

@implementation JUNLinearStackBuilder

NSString * const kJUNFlexLinearArrangement = @"kJUNFlexLinearArrangement";

- (JUNStack *)_getStackWithItems:(NSArray<UIView *> *)items alignment:(JUNFlexAlignment)alignment insets:(UIEdgeInsets)insets {
    id value = nil;
    JUNFlexLinearArrangement arrangement = JUNFlexLinearArrangementSpaceBetween;
    value = self.configurations[kJUNFlexLinearArrangement];
    if (value && [value isKindOfClass:[NSNumber class]]) {
        arrangement = (JUNFlexLinearArrangement)[value integerValue];
    }
    return [self _getStackWithItems:items alignment:alignment arrangement:arrangement insets:insets];
}

- (JUNStack *)_getStackWithItems:(NSArray<UIView *> *)items alignment:(JUNFlexAlignment)alignment arrangement:(JUNFlexLinearArrangement)arrangement insets:(UIEdgeInsets)insets {
    return nil;
}

@end


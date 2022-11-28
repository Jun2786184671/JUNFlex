//
//  JUNFlexBuilder.m
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/27.
//

#import "JUNStackBuilder.h"
#import "JUNStackBuilder+JUNex.h"
#import "JUNStack.h"

@interface JUNStackBuilder ()

@property(nonatomic, strong) NSDictionary *configurations;

@end

@implementation JUNStackBuilder

NSString * const kJUNStackAlignment = @"kJUNStackAlignment";
NSString * const kJUNStackInsets = @"kJUNStackInsets";

- (JUNStackBuilder * _Nonnull (^)(NSDictionary * _Nullable))properties {
    return ^(NSDictionary *configurations) {
        self.configurations = configurations;
        return self;
    };
}

- (JUNStack *)_getStackWithItems:(NSArray<UIView *> *)items alignment:(JUNStackAlignment)alignment insets:(UIEdgeInsets)insets {
    return nil;
}

// build method
- (UIView * _Nonnull (^)(NSArray<UIView *> * _Nonnull))children {
    return ^(NSArray<UIView *> *items) {
        id value = nil;

        JUNStackAlignment alignment = JUNStackAlignmentMainAxisCenter | JUNStackAlignmentCrossAxisCenter;
        value = self.configurations[kJUNStackAlignment];
        if (value && [value isKindOfClass:[NSNumber class]]) {
            alignment = (JUNStackAlignment)[value integerValue];
        }

        UIEdgeInsets insets = UIEdgeInsetsZero;
        value = self.configurations[kJUNStackInsets];
        if (value && [value isKindOfClass:[NSValue class]]) {
            insets = [value UIEdgeInsetsValue];
        }
        return [self _getStackWithItems:items alignment:alignment insets:insets];
    };
}

@end

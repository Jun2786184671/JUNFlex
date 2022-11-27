//
//  JUNFlexBuilder.m
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/27.
//

#import "JUNStackBuilder.h"
#import "JUNStackBuilder+JUNex.h"

@interface JUNStackBuilder ()

@property(nonatomic, strong) NSDictionary *configurations;

@end

@implementation JUNStackBuilder

NSString * const kJUNFlexAlignment = @"kJUNFlexAlignment";
NSString * const kJUNFlexInsetsAll = @"kJUNFlexInsetsAll";
NSString * const kJUNFlexInsets = @"kJUNFlexInsets";
NSString * const kJUNFlexInsetsTop = @"kJUNFlexInsetsTop";
NSString * const kJUNFlexInsetsBottom = @"kJUNFlexInsetsBottom";
NSString * const kJUNFlexInsetsLeft = @"kJUNFlexInsetsLeft";
NSString * const kJUNFlexInsetsRight = @"kJUNFlexInsetsRight";

+ (instancetype)sharedInstance {
    return nil;
}

- (JUNStackBuilder * _Nonnull (^)(NSDictionary * _Nullable))properties {
    return ^(NSDictionary *configurations) {
        self.configurations = configurations;
        return self;
    };
}

- (JUNStack *)_getStackWithItems:(NSArray<UIView *> *)items alignment:(JUNFlexAlignment)alignment insets:(UIEdgeInsets)insets {
    return nil;
}

// build method
- (UIView * _Nonnull (^)(NSArray<UIView *> * _Nonnull))children {
    return ^(NSArray<UIView *> *items) {
        id value = nil;

        JUNFlexAlignment alignment = JUNFlexAlignmentCenter;
        value = self.configurations[kJUNFlexAlignment];
        if (value && [value isKindOfClass:[NSNumber class]]) {
            alignment = (JUNFlexAlignment)[value integerValue];
        }

        UIEdgeInsets insets = UIEdgeInsetsZero;
        value = self.configurations[kJUNFlexInsetsAll];
        if (value && [value isKindOfClass:[NSNumber class]]) {
            CGFloat inset = [value floatValue];
            insets = UIEdgeInsetsMake(inset, inset, inset, inset);
        }
        value = self.configurations[kJUNFlexInsets];
        if (value && [value isKindOfClass:[NSValue class]]) {
            insets = [value UIEdgeInsetsValue];
        }
        value = self.configurations[kJUNFlexInsetsTop];
        if (value && [value isKindOfClass:[NSNumber class]]) {
            insets.top = [value floatValue];
        }
        value = self.configurations[kJUNFlexInsetsBottom];
        if (value && [value isKindOfClass:[NSNumber class]]) {
            insets.bottom = [value floatValue];
        }
        value = self.configurations[kJUNFlexInsetsLeft];
        if (value && [value isKindOfClass:[NSNumber class]]) {
            insets.left = [value floatValue];
        }
        value = self.configurations[kJUNFlexInsetsRight];
        if (value && [value isKindOfClass:[NSNumber class]]) {
            insets.right = [value floatValue];
        }
        return [self _getStackWithItems:items alignment:alignment insets:insets];
    };
}

@end

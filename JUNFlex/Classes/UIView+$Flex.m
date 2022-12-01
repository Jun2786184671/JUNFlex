//
//  UIView+_Flex.m
//  JUNFlex
//
//  Created by Jun Ma on 2022/12/1.
//

#import "UIView+$Flex.h"

@implementation UIView ($Flex)

- (void (^)(NSString * _Nonnull))$ID {
    return ^(NSString *identifier) {
        self.accessibilityIdentifier = identifier;
    };
}

- (UIView * _Nullable (^)(NSString * _Nonnull))$query {
    return ^UIView *(NSString *identifier) {
        if ([self.accessibilityIdentifier isEqualToString:identifier]) return self;
        for (UIView *subview in self.subviews) {
            UIView *result = subview.$query(identifier);
            if (result) return result;
        }
        return nil;
    };
}

@end

//
//  UIView+$Flex.m
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

- (NSArray<UIView *> * _Nullable (^)(NSString * _Nonnull))$query {
    return ^NSArray<UIView *> *(NSString *identifier) {
        NSMutableArray<UIView *> *results = [NSMutableArray arrayWithCapacity:self.subviews.count + 1];
        if ([self.accessibilityIdentifier isEqualToString:identifier]) {
            [results addObject:self];
        }
        for (UIView *subview in self.subviews) {
            NSArray<UIView *> *result = subview.$query(identifier);
            if (result) {
                [results addObjectsFromArray:result];
            }
        }
        return results;
    };
}

- (UIView * _Nullable (^)(NSString * _Nonnull))$query0 {
    return ^UIView *(NSString *identifier) {
        if ([self.accessibilityIdentifier isEqualToString:identifier]) return self;
        for (UIView *subview in self.subviews) {
            UIView *result = subview.$query0(identifier);
            if (result) return result;
        }
        return nil;
    };
}

- (void)set$data:(id)$data {
    return;
}

- (id _Nullable)$data {
    return nil;
}

@end

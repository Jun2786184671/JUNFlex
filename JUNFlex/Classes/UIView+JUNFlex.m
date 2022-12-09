//
//  UIView+JUNFlex.m
//  JUNFlex
//
//  Created by Jun Ma on 2022/12/1.
//

#import "UIView+JUNFlex.h"

@implementation UIView (JUNFlex)

- (void (^)(NSString * _Nonnull))jun_ID {
    return ^(NSString *identifier) {
        self.accessibilityIdentifier = identifier;
    };
}

- (NSArray<UIView *> * _Nullable (^)(NSString * _Nonnull))jun_query {
    return ^NSArray<UIView *> *(NSString *identifier) {
        NSMutableArray<UIView *> *results = [NSMutableArray arrayWithCapacity:self.subviews.count + 1];
        if ([self.accessibilityIdentifier isEqualToString:identifier]) {
            [results addObject:self];
        }
        for (UIView *subview in self.subviews) {
            NSArray<UIView *> *result = subview.jun_query(identifier);
            if (result) {
                [results addObjectsFromArray:result];
            }
        }
        return results;
    };
}

- (UIView * _Nullable (^)(NSString * _Nonnull))jun_query0 {
    return ^UIView *(NSString *identifier) {
        if ([self.accessibilityIdentifier isEqualToString:identifier]) return self;
        for (UIView *subview in self.subviews) {
            UIView *result = subview.jun_query0(identifier);
            if (result) return result;
        }
        return nil;
    };
}

- (id _Nullable)jun_data {
    return nil;
}

@end

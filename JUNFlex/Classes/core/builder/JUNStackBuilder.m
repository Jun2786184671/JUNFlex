//
//  JUNFlexBuilder.m
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/27.
//

#import "JUNStackBuilder.h"
#import "JUNStackBuilder+JUNex.h"
#import "JUNStack.h"
#import "JUNItemBuilder.h"

@interface JUNStackBuilder ()

@property(nonatomic, copy) NSString *$ID;
@property(nonatomic, strong) UIColor *$color;
@property(nonatomic, assign) CGFloat $alpha;
@property(nonatomic, assign) CGFloat $radius;
@property(nonatomic, assign) CGFloat $width;
@property(nonatomic, assign) CGFloat $height;
@property(nonatomic, assign) CGPoint $align;
@property(nonatomic, assign) bool $maskBounds;

@end

@implementation JUNStackBuilder

- (JUNStackBuilder * _Nonnull (^)(NSString * _Nonnull))ID {
    return ^(NSString *ID) {
        self.$ID = ID;
        return self;
    };
}

- (JUNStackBuilder * _Nonnull (^)(UIColor * _Nonnull))color {
    return ^(UIColor *color) {
        self.$color = color;
        return self;
    };
}

- (JUNStackBuilder * _Nonnull (^)(CGFloat))radius {
    return ^(CGFloat radius) {
        self.$radius = radius;
        return self;
    };
}

- (JUNStackBuilder * _Nonnull (^)(bool))maskBounds {
    return ^(bool maskBounds) {
        self.$maskBounds = maskBounds;
        return self;
    };
}

- (JUNStackBuilder * _Nonnull (^)(CGFloat))alpha {
    return ^(CGFloat alpha) {
        self.$alpha = alpha;
        return self;
    };
}

- (JUNStackBuilder * _Nonnull (^)(CGFloat))width {
    return ^(CGFloat width) {
        self.$width = width;
        return self;
    };
}

- (JUNStackBuilder * _Nonnull (^)(CGFloat))height {
    return ^(CGFloat height) {
        self.$height = height;
        return self;
    };
}

- (JUNStackBuilder * _Nonnull (^)(CGSize))size {
    return ^(CGSize size) {
        self.width(size.width);
        self.height(size.height);
        return self;
    };
}

- (JUNStack *)_getStackWithItems:(NSArray<UIView *> *)items alignment:(JUNStackAlignment)alignment insets:(UIEdgeInsets)insets {
    return nil;
}

- (JUNStackBuilder * _Nonnull (^)(CGPoint))align {
    return ^(CGPoint align) {
        self.$align = align;
        return self;
    };
}

// build method
- (UIView * _Nonnull (^)(NSArray<UIView *> * _Nonnull))children {
    return ^(NSArray<UIView *> *items) {
        
        JUNStackAlignment alignMain = JUNStackAlignmentMainAxisCenter;
        if (self.$align.x > 0) {
            alignMain = JUNStackAlignmentMainAxisMax;
        } else if (self.$align.x < 0) {
            alignMain = JUNStackAlignmentMainAxisMin;
        }
        
        JUNStackAlignment alignCross = JUNStackAlignmentCrossAxisCenter;
        if (self.$align.y > 0) {
            alignCross = JUNStackAlignmentCrossAxisMax;
        } else if (self.$align.y < 0) {
            alignCross = JUNStackAlignmentCrossAxisMin;
        }
        
        JUNStackAlignment align = alignMain | alignCross;
        
        NSArray<UIView *> *validItems = [self _validateItems:items];
        JUNStack *stack = [self _getStackWithItems:validItems alignment:align insets:UIEdgeInsetsZero];
        CGRect frame = stack.frame;
        
        if (self.$width) {
            NSLayoutConstraint *wConstraint = [NSLayoutConstraint constraintWithItem:stack attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:self.$width];
            wConstraint.priority = UILayoutPriorityDefaultHigh;
            [stack addConstraints:@[
                wConstraint,
                [NSLayoutConstraint constraintWithItem:stack attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationLessThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:self.$width],
            ]];
            frame.size.width = self.$width;
        }
        
        if (self.$height) {
            NSLayoutConstraint *hConstraint = [NSLayoutConstraint constraintWithItem:stack attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:self.$height];
            hConstraint.priority = UILayoutPriorityDefaultHigh;
            [stack addConstraints:@[
                hConstraint,
                [NSLayoutConstraint constraintWithItem:stack attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationLessThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:self.$height],
            ]];
            frame.size.height = self.$height;
        }
        
        stack.frame = frame;
        
        if (self.$ID) {
            stack.accessibilityIdentifier = self.$ID;
        }
        if (self.$radius) {
            stack.layer.cornerRadius = self.$radius;
        }
        
        stack.layer.masksToBounds = self.$maskBounds;
        
        if (self.$color) {
            stack.backgroundColor = self.$color;
        }
        if (self.$alpha) {
            stack.alpha = self.$alpha;
        }
        return stack;
    };
}

- (NSArray<UIView *> *)_validateItems:(NSArray<UIView *> *)items {
    NSMutableArray *validItems = [NSMutableArray arrayWithArray:items];
    for (int i = 0; i < items.count; i++) {
        id item = items[i];
        if ([item isKindOfClass:[JUNItemBuilder class]]) {
            JUNItemBuilder *builder = (JUNItemBuilder *)item;
            [validItems replaceObjectAtIndex:i withObject:builder.end];
        }
    }
    return [validItems copy];
}

@end

//
//  JUNInsetWrapper.m
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/29.
//

#import "JUNPaddingBuilder.h"
#import "JUNItemBuilder.h"
#import "UIView+JUNex4Flex.h"

@interface JUNPaddingBuilder ()

@property(nonatomic, copy) NSString *$ID;
@property(nonatomic, strong) UIColor *$color;
@property(nonatomic, assign) CGFloat $alpha;
@property(nonatomic, assign) CGFloat $radius;
@property(nonatomic, assign) bool $maskBounds;
@property(nonatomic, assign) CGFloat $width;
@property(nonatomic, assign) CGFloat $height;
@property(nonatomic, assign) UIEdgeInsets $paddings;

@end

@implementation JUNPaddingBuilder

- (instancetype)init {
    if (self = [super init]) {
        self.$paddings = UIEdgeInsetsZero;
    }
    return self;
}

- (JUNPaddingBuilder * _Nonnull (^)(NSString * _Nonnull))ID {
    return ^(NSString *ID) {
        self.$ID = ID;
        return self;
    };
}

- (JUNPaddingBuilder * _Nonnull (^)(UIColor * _Nonnull))color {
    return ^(UIColor *color) {
        self.$color = color;
        return self;
    };
}

- (JUNPaddingBuilder * _Nonnull (^)(CGFloat))radius {
    return ^(CGFloat radius) {
        self.$radius = radius;
        return self;
    };
}

- (JUNPaddingBuilder * _Nonnull (^)(bool))maskBounds {
    return ^(bool maskBounds) {
        self.$maskBounds = maskBounds;
        return self;
    };
}

- (JUNPaddingBuilder * _Nonnull (^)(CGFloat))alpha {
    return ^(CGFloat alpha) {
        self.$alpha = alpha;
        return self;
    };
}

- (JUNPaddingBuilder * _Nonnull (^)(CGFloat))width {
    return ^(CGFloat width) {
        self.$width = width;
        return self;
    };
}

- (JUNPaddingBuilder * _Nonnull (^)(CGFloat))height {
    return ^(CGFloat height) {
        self.$height = height;
        return self;
    };
}

- (JUNPaddingBuilder * _Nonnull (^)(CGSize))size {
    return ^(CGSize size) {
        self.width(size.width);
        self.height(size.height);
        return self;
    };
}

- (JUNPaddingBuilder * _Nonnull (^)(CGFloat))top {
    return ^(CGFloat top) {
        UIEdgeInsets paddings = self.$paddings;
        paddings.top = top;
        self.$paddings = paddings;
        return self;
    };
}

- (JUNPaddingBuilder * _Nonnull (^)(CGFloat))left {
    return ^(CGFloat left) {
        UIEdgeInsets paddings = self.$paddings;
        paddings.left = left;
        self.$paddings = paddings;
        return self;
    };
}

- (JUNPaddingBuilder * _Nonnull (^)(CGFloat))bottom {
    return ^(CGFloat bottom) {
        UIEdgeInsets paddings = self.$paddings;
        paddings.bottom = bottom;
        self.$paddings = paddings;
        return self;
    };
}

- (JUNPaddingBuilder * _Nonnull (^)(CGFloat))right {
    return ^(CGFloat right) {
        UIEdgeInsets paddings = self.$paddings;
        paddings.right = right;
        self.$paddings = paddings;
        return self;
    };
}

- (JUNPaddingBuilder * _Nonnull (^)(CGFloat))all {
    return ^(CGFloat all) {
        self.$paddings = UIEdgeInsetsMake(all, all, all, all);
        return self;
    };
}

- (JUNPaddingBuilder * _Nonnull (^)(CGFloat, CGFloat, CGFloat, CGFloat))make {
    return ^(CGFloat t, CGFloat l, CGFloat b, CGFloat r) {
        self.$paddings = UIEdgeInsetsMake(t, l, b, r);
        return self;
    };
}

- (UIView * _Nonnull (^)(id _Nonnull))child {
    return ^(id target) {
        UIView *validTarget = [self _validateTarget:target];
        UIView *wrappedTarget = [validTarget jun_wrapWithInset:self.$paddings];
        CGRect frame = wrappedTarget.frame;
        
        if (self.$width) {
            NSLayoutConstraint *wConstraint = [NSLayoutConstraint constraintWithItem:wrappedTarget attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:self.$width];
            wConstraint.priority = UILayoutPriorityDefaultHigh;
            [wrappedTarget addConstraints:@[
                [NSLayoutConstraint constraintWithItem:wrappedTarget attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:self.$width],
                wConstraint,
            ]];
            frame.size.width = self.$width;
        }
        if (self.$height) {
            NSLayoutConstraint *hConstraint = [NSLayoutConstraint constraintWithItem:wrappedTarget attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:self.$height];
            hConstraint.priority = UILayoutPriorityDefaultHigh;
            [wrappedTarget addConstraints:@[
                [NSLayoutConstraint constraintWithItem:wrappedTarget attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:self.$height],
                hConstraint,
            ]];
            frame.size.height = self.$height;
        }
        
        wrappedTarget.frame = frame;
        
        if (self.$ID) {
            wrappedTarget.accessibilityIdentifier = self.$ID;
        }
        if (self.$radius) {
            wrappedTarget.layer.cornerRadius = self.$radius;
        }
        
        wrappedTarget.layer.masksToBounds = self.$maskBounds;
        
        if (self.$color) {
            wrappedTarget.backgroundColor = self.$color;
        }
        if (self.$alpha) {
            wrappedTarget.alpha = self.$alpha;
        }
        return wrappedTarget;
    };
}

- (UIView *)_validateTarget:(id)target {
    if ([target isKindOfClass:[UIView class]]) {
        return target;
    } else if ([target isKindOfClass:[JUNItemBuilder class]]) {
        JUNItemBuilder *builder = (JUNItemBuilder *)target;
        return builder.end;
    }
    NSAssert(false, @"child of padding must be a uiview or itembuilder");
    return nil;
}

@end

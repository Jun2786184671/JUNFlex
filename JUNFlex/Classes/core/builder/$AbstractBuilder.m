//
//  $AbstractBuilder.m
//  JUNFlex
//
//  Created by Jun Ma on 2022/12/1.
//

#import "$AbstractBuilder.h"

@interface $AbstractBuilder ()

@property(nonatomic, readonly) UIView *product;

@end

@implementation $AbstractBuilder

@dynamic product;

- (id _Nonnull (^)(NSString * _Nonnull))ID {
    return ^(NSString *identifier) {
        self.product.accessibilityIdentifier = identifier;
        return self;
    };
}

- (id _Nonnull (^)(UIColor *))color {
    return ^(UIColor *color) {
        self.product.backgroundColor = color;
        return self;
    };
}

- (id _Nonnull (^)(CGFloat))alpha {
    return ^(CGFloat alpha) {
        self.product.alpha = alpha;
        return self;
    };
}

- (id _Nonnull (^)(CGFloat))radius {
    return ^(CGFloat radius) {
        self.product.layer.cornerRadius = radius;
        return self;
    };
}

- (id  _Nonnull (^)(CGFloat, UIColor * _Nonnull))border {
    return ^(CGFloat width, UIColor *color) {
        self.product.layer.borderWidth = width;
        self.product.layer.borderColor = color.CGColor;
        return self;
    };
}

- (id _Nonnull (^)(bool))maskBounds {
    return ^(bool maskBounds) {
        self.product.layer.masksToBounds = maskBounds;
        return self;
    };
}

- (id _Nonnull (^)(CGFloat))width {
    return ^(CGFloat width) {
        NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:self.product attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:width];
        widthConstraint.priority = UILayoutPriorityDefaultHigh;
        [self.product addConstraint:widthConstraint];
        CGRect frame = self.product.frame;
        frame.size.width = width;
        self.product.frame = frame;
        return self;
    };
}

- (id _Nonnull (^)(CGFloat))height {
    return ^(CGFloat height) {
        NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self.product attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:height];
        heightConstraint.priority = UILayoutPriorityDefaultHigh;
        [self.product addConstraint:heightConstraint];
        CGRect frame = self.product.frame;
        frame.size.height = height;
        self.product.frame = frame;
        return self;
    };
}

- (id _Nonnull (^)(CGSize))size {
    return ^(CGSize size) {
        self.width(size.width);
        self.height(size.height);
        return self;
    };
}

- (id)EOB {
    return self.product;
}

@end

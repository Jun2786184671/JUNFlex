//
//  JUNWidgetBuilder.m
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/29.
//

#import "$ItemBuilder.h"
#import "JUNItemBuilder+Private.h"
#import "UIColor+JUNex4Flex.h"
#import "NSURL+JUNex4Flex.h"
#import <SDWebImage/SDWebImage.h>

@implementation $ItemBuilder
@synthesize target = _target;

- (JUNItem *)target {
    if (_target == nil) {
        _target = [JUNItem buttonWithType:UIButtonTypeCustom];
        _target.translatesAutoresizingMaskIntoConstraints = false;
        _target.backgroundColor = [UIColor clearColor];
        _target.adjustsImageWhenDisabled = false;
        _target.adjustsImageWhenHighlighted = false;
    }
    return _target;
}

- ($ItemBuilder * _Nonnull (^)(NSString * _Nonnull))ID {
    return ^(NSString *identifier) {
        self.target.accessibilityIdentifier = identifier;
        return self;
    };
}

- ($ItemBuilder * _Nonnull (^)(UIColor *))color {
    return ^(UIColor *color) {
        self.target.backgroundColor = color;
        return self;
    };
}

- ($ItemBuilder * _Nonnull (^)(CGFloat))alpha {
    return ^(CGFloat alpha) {
        self.target.alpha = alpha;
        return self;
    };
}

- ($ItemBuilder * _Nonnull (^)(NSString * _Nonnull, CGFloat, UIColor *))text {
    return ^(NSString *text, CGFloat fontSize, UIColor *color) {
        [self.target setTitle:text forState:UIControlStateNormal];
        [self.target setTitleColor:color forState:UIControlStateNormal];
        self.target.titleLabel.font = [UIFont systemFontOfSize:fontSize];
        return self;
    };
}

- ($ItemBuilder * _Nonnull (^)(NSString * _Nonnull))image {
    return ^(NSString *nameOrURL) {
        NSURL *url = [NSURL URLWithString:nameOrURL];
        if ([url jun_isValid]) {
            [self.target sd_setBackgroundImageWithURL:url forState:UIControlStateNormal placeholderImage:nil];
        } else {
            UIImage *image = [UIImage imageNamed:nameOrURL];
            [self.target setBackgroundImage:image forState:UIControlStateNormal];
        }
        return self;
    };
}

- ($ItemBuilder * _Nonnull (^)(CGFloat))radius {
    return ^(CGFloat radius) {
        self.target.layer.cornerRadius = radius;
        return self;
    };
}

- ($ItemBuilder * _Nonnull (^)(bool))maskBounds {
    return ^(bool maskBounds) {
        self.target.layer.masksToBounds = maskBounds;
        return self;
    };
}

- ($ItemBuilder * _Nonnull (^)(CGFloat))width {
    return ^(CGFloat width) {
        NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:self.target attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:width];
        widthConstraint.priority = UILayoutPriorityDefaultHigh;
        [self.target addConstraint:widthConstraint];
        CGRect frame = self.target.frame;
        frame.size.width = width;
        self.target.frame = frame;
        return self;
    };
}

- ($ItemBuilder * _Nonnull (^)(CGFloat))height {
    return ^(CGFloat height) {
        NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self.target attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:height];
        heightConstraint.priority = UILayoutPriorityDefaultHigh;
        [self.target addConstraint:heightConstraint];
        CGRect frame = self.target.frame;
        frame.size.height = height;
        self.target.frame = frame;
        return self;
    };
}

- ($ItemBuilder * _Nonnull (^)(CGSize))size {
    return ^(CGSize size) {
        self.width(size.width);
        self.height(size.height);
        return self;
    };
}

- ($ItemBuilder * _Nonnull (^)(id _Nonnull, SEL _Nonnull))onTap {
    return ^(id target, SEL selector) {
        [self.target addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
        return self;
    };
}

- (JUNItem *)end {
    return self.target;
}

@end

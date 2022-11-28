//
//  JUNWidgetBuilder.m
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/29.
//

#import "JUNItemBuilder.h"
#import "UIColor+JUNex4Flex.h"
#import "NSURL+JUNex4Flex.h"
#import "JUNItem.h"
#import <SDWebImage/SDWebImage.h>

@interface JUNItemBuilder ()

@property(nonatomic, strong) UIButton *target;

@end

@implementation JUNItemBuilder

- (UIButton *)target {
    if (_target == nil) {
        _target = [JUNItem buttonWithType:UIButtonTypeCustom];
        _target.translatesAutoresizingMaskIntoConstraints = false;
        _target.userInteractionEnabled = false;
        _target.backgroundColor = [UIColor clearColor];
    }
    return _target;
}

- (JUNItemBuilder * _Nonnull (^)(NSString * _Nonnull))ID {
    return ^(NSString *ID) {
        self.target.accessibilityIdentifier = ID;
        return self;
    };
}

- (JUNItemBuilder * _Nonnull (^)(UIColor *))color {
    return ^(UIColor *color) {
        self.target.backgroundColor = color;
        return self;
    };
}

- (JUNItemBuilder * _Nonnull (^)(CGFloat))alpha {
    return ^(CGFloat a) {
        self.target.alpha = a;
        return self;
    };
}

- (JUNItemBuilder * _Nonnull (^)(NSString * _Nonnull, CGFloat, UIColor *))text {
    return ^(NSString *text, CGFloat fontSize, UIColor *color) {
        [self.target setTitle:text forState:UIControlStateNormal];
        [self.target setTitleColor:color forState:UIControlStateNormal];
        self.target.titleLabel.font = [UIFont systemFontOfSize:fontSize];
        return self;
    };
}

- (JUNItemBuilder * _Nonnull (^)(NSString * _Nonnull))image {
    return ^(NSString *nameOrURL) {
        NSURL *url = [NSURL URLWithString:nameOrURL];
        if ([url jun_isValid]) {
//            [self.target.imageView sd_setImageWithURL:url placeholderImage:nil];
            [self.target sd_setBackgroundImageWithURL:url forState:UIControlStateNormal placeholderImage:nil];
        } else {
            UIImage *image = [UIImage imageNamed:nameOrURL];
//            [self.target setImage:image forState:UIControlStateNormal];
            [self.target setBackgroundImage:image forState:UIControlStateNormal];
        }
        return self;
    };
}

- (JUNItemBuilder * _Nonnull (^)(CGFloat))radius {
    return ^(CGFloat radius) {
        self.target.layer.cornerRadius = radius;
        return self;
    };
}

- (JUNItemBuilder * _Nonnull (^)(bool))maskBounds {
    return ^(bool maskBounds) {
        self.target.layer.masksToBounds = maskBounds;
        return self;
    };
}

- (JUNItemBuilder * _Nonnull (^)(CGFloat))width {
    return ^(CGFloat width) {
        NSLayoutConstraint *wConstraint = [NSLayoutConstraint constraintWithItem:self.target attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:width];
        wConstraint.priority = UILayoutPriorityDefaultHigh;
        [self.target addConstraint:wConstraint];
        CGRect frame = self.target.frame;
        frame.size.width = width;
        self.target.frame = frame;
        return self;
    };
}

- (JUNItemBuilder * _Nonnull (^)(CGFloat))height {
    return ^(CGFloat height) {
        NSLayoutConstraint *hConstraint = [NSLayoutConstraint constraintWithItem:self.target attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:height];
        hConstraint.priority = UILayoutPriorityDefaultHigh;
        [self.target addConstraint:hConstraint];
        CGRect frame = self.target.frame;
        frame.size.height = height;
        self.target.frame = frame;
        return self;
    };
}

- (JUNItemBuilder * _Nonnull (^)(CGSize))size {
    return ^(CGSize size) {
        self.width(size.width);
        self.height(size.height);
        return self;
    };
}

- (JUNItemBuilder * _Nonnull (^)(id _Nonnull, SEL _Nonnull))onTap {
    return ^(id target, SEL selector) {
        self.target.userInteractionEnabled = true;
        [self.target addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
        return self;
    };
}

- (UIView *)end {
    return self.target;
}

@end

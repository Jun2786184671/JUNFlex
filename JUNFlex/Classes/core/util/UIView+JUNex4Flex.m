//
//  UIView+JUNex4Flex.m
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/28.
//

#import "UIView+JUNex4Flex.h"
#import "JUNPadding.h"
#import "JUNItem.h"

@implementation UIView (JUNex4Flex)

- (void)jun_addDefaultConstraintsIfNeeded {
    if (self.superview == nil) return;
    if ([self _isConstraintedInSuperview]) return;
    [self _addDefaultConstraintsToSuperview];
}

- (bool)_isConstraintedInSuperview {
    for (NSLayoutConstraint *constraint in self.superview.constraints) {
        if (constraint.firstItem == self || constraint.secondItem == self) return true;
    }
    return false;
}

- (void)_addDefaultConstraintsToSuperview {
    [self.superview addConstraints:@[
        [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self.superview attribute:NSLayoutAttributeTop multiplier:1.0f constant:0.0f],
        [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self.superview attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0.0f],
        [NSLayoutConstraint constraintWithItem:self.superview attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0.0f],
        [NSLayoutConstraint constraintWithItem:self.superview attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0.0f],
        [NSLayoutConstraint constraintWithItem:self.superview attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f],
        [NSLayoutConstraint constraintWithItem:self.superview attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0.0f],
    ]];
}

- (CGRect)jun_validateFrame {
    CGRect frame = self.frame;
    CGFloat w = frame.size.width;
    CGFloat h = frame.size.height;
    if (!w || !h) {
        [self sizeToFit];
        w = w ? w : self.frame.size.width;
        h = h ? h : self.frame.size.height;
        frame.size.width = w;
        frame.size.height = h;
        self.frame = frame;
    }
    return frame;
}

- (UIView *)jun_wrapWithInset:(UIEdgeInsets)insets {
    self.translatesAutoresizingMaskIntoConstraints = false;
    UIView *wrapper = [[JUNPadding alloc] init];
    wrapper.translatesAutoresizingMaskIntoConstraints = false;
    [wrapper addSubview:self];
    [wrapper addConstraints:@[
        
        [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:wrapper attribute:NSLayoutAttributeTop multiplier:1.0f constant:insets.top],
        [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:wrapper attribute:NSLayoutAttributeBottom multiplier:1.0f constant:-insets.bottom],
        [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:wrapper attribute:NSLayoutAttributeLeading multiplier:1.0f constant:insets.left],
        [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:wrapper attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:-insets.right],
    ]];
    return wrapper;
}

@end

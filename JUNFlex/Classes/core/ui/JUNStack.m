//
//  JUNStack.m
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/27.
//

#import "JUNStack.h"

@interface JUNStack ()

@property(nonatomic, strong) NSArray<UIView *> *items;
@property(nonatomic, assign) JUNStackAlignment alignment;
@property(nonatomic, assign) UIEdgeInsets insets;

@end

@implementation JUNStack

- (void)didMoveToWindow {
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
        [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeTop multiplier:1.0f constant:0.0f],
        [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0.0f],
        [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0.0f],
        [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0.0f],
    ]];
}

- (instancetype)initWithItems:(NSArray<UIView *> *)items alignment:(JUNStackAlignment)alignment insets:(UIEdgeInsets)insets {
    if (self = [super init]) {
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.items = items;
        self.alignment = alignment;
        self.insets = insets;
    }
    return self;
}

@end

//
//  JUNItem.m
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/29.
//

#import "JUNItem.h"
#import "UIView+JUNFlex.h"
#import "UIView+JUNFlex_Private.h"

@interface JUNItem ()

@property(nonatomic, strong, nullable) id jun_data;

@end

@implementation JUNItem

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.backgroundColor = [UIColor clearColor];
        self.adjustsImageWhenDisabled = false;
        self.adjustsImageWhenHighlighted = false;
    }
    return self;
}

- (void)didMoveToWindow {
    [self _addDefaultConstraintsIfNeeded];
}

- (void)sizeToFit {
    if (!self.currentImage || !self.currentTitle.length) return;
    [super sizeToFit];
}

- (void)_addDefaultConstraintsIfNeeded {
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
    NSLayoutConstraint *widthContraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeWidth multiplier:1.0f constant:0.0f];
    widthContraint.priority = UILayoutPriorityDefaultHigh;
    
    NSLayoutConstraint *heightContraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeHeight multiplier:1.0f constant:0.0f];
    heightContraint.priority = UILayoutPriorityDefaultHigh;
    
    [self.superview addConstraints:@[
        [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self.superview attribute:NSLayoutAttributeTop multiplier:1.0f constant:0.0f],
        [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self.superview attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0.0f],
        [NSLayoutConstraint constraintWithItem:self.superview attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0.0f],
        [NSLayoutConstraint constraintWithItem:self.superview attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0.0f],
        [NSLayoutConstraint constraintWithItem:self.superview attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f],
        [NSLayoutConstraint constraintWithItem:self.superview attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0.0f],
        widthContraint,
        heightContraint,
    ]];
}

@end

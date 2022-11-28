//
//  JUNStack.m
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/27.
//

#import "JUNStack.h"
#import "UIView+JUNex4Flex.h"

@interface JUNStack ()

@property(nonatomic, strong) NSArray<UIView *> *items;
@property(nonatomic, assign) JUNStackAlignment alignment;
@property(nonatomic, assign) UIEdgeInsets insets;

@end

@implementation JUNStack

- (void)didMoveToWindow {
    [self jun_addDefaultConstraintsIfNeeded];
}

- (instancetype)initWithItems:(NSArray<UIView *> *)items alignment:(JUNStackAlignment)alignment insets:(UIEdgeInsets)insets {
    if (self = [super init]) {
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.items = items;
        self.alignment = alignment;
        self.insets = insets;
        [self _addHugConstraints];
        
    }
    return self;
}

- (void)_addHugConstraints {
    NSLayoutConstraint *hConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:0.0f];
    hConstraint.priority = UILayoutPriorityDefaultLow;
    NSLayoutConstraint *vConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:0.0f];
    vConstraint.priority = UILayoutPriorityDefaultLow;
    [self addConstraints:@[hConstraint, vConstraint]];
}

@end

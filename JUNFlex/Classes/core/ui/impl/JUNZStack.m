//
//  JUNZStack.m
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/28.
//

#import "JUNZStack.h"

#import "UIView+JUNex4Flex.h"

@implementation JUNZStack

- (instancetype)initWithItems:(NSArray<UIView *> *)items alignment:(JUNStackAlignment)alignment insets:(UIEdgeInsets)insets {
    if (self = [super initWithItems:items alignment:alignment insets:insets]) {
        [self _setUpItems];
    }
    return self;
}

- (void)_setUpItems {
    UIView *prevItem = self;
    for (UIView *item in self.items) {
        item.translatesAutoresizingMaskIntoConstraints = false;
        [item jun_validateFrame];
        [prevItem addSubview:item];
        [self _setUpConstraintsForItem:item prevItem:prevItem];
        prevItem = item;
    }
}

- (void)_setUpConstraintsForItem:(UIView *)item prevItem:(UIView *)prevItem {
    [self _setUpConstraintsForItem:item prevItem:prevItem axis:0];
    [self _setUpConstraintsForItem:item prevItem:prevItem axis:1];
}

- (void)_setUpConstraintsForItem:(UIView *)item prevItem:(UIView *)prevItem axis:(bool)isMainAxis {
    CGSize itemSize = item.frame.size;
    CGFloat itemSpan = isMainAxis ? itemSize.width : itemSize.height;
    CGFloat infInset = isMainAxis ? self.insets.left : self.insets.top;
    CGFloat supInset = isMainAxis ? self.insets.right : self.insets.bottom;
    
    JUNStackAlignment infAlign = isMainAxis ? JUNStackAlignmentMainAxisMin : JUNStackAlignmentCrossAxisMin;
    JUNStackAlignment supAlign = isMainAxis ? JUNStackAlignmentMainAxisMax : JUNStackAlignmentCrossAxisMax;
    
    NSLayoutAttribute spanAttribute = isMainAxis ? NSLayoutAttributeWidth : NSLayoutAttributeHeight;
    NSLayoutAttribute infAttribute = isMainAxis ? NSLayoutAttributeLeading : NSLayoutAttributeTop;
    NSLayoutAttribute supAttribute = isMainAxis ? NSLayoutAttributeTrailing : NSLayoutAttributeBottom;
    NSLayoutAttribute midAttribute = isMainAxis ? NSLayoutAttributeCenterX : NSLayoutAttributeCenterY;
    
    NSLayoutRelation boundConstraintRelation = NSLayoutRelationEqual;
    
    if (itemSpan) {
        NSLayoutConstraint *spanConstraint = [NSLayoutConstraint
                                               constraintWithItem:item
                                               attribute:spanAttribute
                                               relatedBy:NSLayoutRelationEqual
                                               toItem:nil
                                               attribute:NSLayoutAttributeNotAnAttribute
                                               multiplier:1.0f constant:itemSpan];
        spanConstraint.priority = UILayoutPriorityDefaultHigh;
        [item addConstraints:@[
            spanConstraint,
            [NSLayoutConstraint constraintWithItem:item attribute:spanAttribute relatedBy:NSLayoutRelationLessThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:itemSpan],
        ]];
        
        boundConstraintRelation = NSLayoutRelationGreaterThanOrEqual;
    }
    
    NSLayoutConstraint *infConstraint = [NSLayoutConstraint
                                              constraintWithItem:item
                                              attribute:infAttribute
                                              relatedBy:boundConstraintRelation
                                              toItem:prevItem
                                              attribute:infAttribute
                                              multiplier:1.0f constant:infInset];
    
    NSLayoutConstraint *supConstraint = [NSLayoutConstraint
                                              constraintWithItem:prevItem
                                              attribute:supAttribute
                                              relatedBy:boundConstraintRelation
                                              toItem:item
                                              attribute:supAttribute
                                              multiplier:1.0f constant:supInset];
    
    [prevItem addConstraints:@[
        infConstraint,
        supConstraint,
    ]];
    
    NSLayoutConstraint *positionConstraint;
    if (self.alignment & infAlign) {
        positionConstraint = [NSLayoutConstraint constraintWithItem:item attribute:infAttribute relatedBy:NSLayoutRelationEqual toItem:prevItem attribute:infAttribute multiplier:1.0f constant:infInset];
    } else if (self.alignment & supAlign) {
        positionConstraint = [NSLayoutConstraint constraintWithItem:prevItem attribute:supAttribute relatedBy:NSLayoutRelationEqual toItem:item attribute:supAttribute multiplier:1.0f constant:supInset];
    } else {
        positionConstraint = [NSLayoutConstraint constraintWithItem:prevItem attribute:midAttribute relatedBy:NSLayoutRelationEqual toItem:item attribute:midAttribute multiplier:1.0f constant:0.0f];
    }
    [prevItem addConstraint:positionConstraint];
}

@end

//
//  JUNZStack.m
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/28.
//

#import "JUNZStack.h"

#import "UIView+JUNex4Flex.h"

@implementation JUNZStack

- (instancetype)initWithItems:(NSArray<UIView *> *)items alignment:(CGPoint)alignment {
    if (self = [super initWithItems:items alignment:alignment]) {
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
    CGFloat axisAlign = isMainAxis ? self.alignment.x : self.alignment.y;
    
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
                                              multiplier:1.0f constant:0.0f];
    
    NSLayoutConstraint *supConstraint = [NSLayoutConstraint
                                              constraintWithItem:prevItem
                                              attribute:supAttribute
                                              relatedBy:boundConstraintRelation
                                              toItem:item
                                              attribute:supAttribute
                                              multiplier:1.0f constant:0.0f];
    
    [prevItem addConstraints:@[
        infConstraint,
        supConstraint,
    ]];
    
    NSLayoutConstraint *positionConstraint;
    if (axisAlign < 0) {
        positionConstraint = [NSLayoutConstraint constraintWithItem:item attribute:infAttribute relatedBy:NSLayoutRelationEqual toItem:prevItem attribute:infAttribute multiplier:1.0f constant:0.0f];
    } else if (axisAlign > 0) {
        positionConstraint = [NSLayoutConstraint constraintWithItem:prevItem attribute:supAttribute relatedBy:NSLayoutRelationEqual toItem:item attribute:supAttribute multiplier:1.0f constant:0.0f];
    } else {
        positionConstraint = [NSLayoutConstraint constraintWithItem:prevItem attribute:midAttribute relatedBy:NSLayoutRelationEqual toItem:item attribute:midAttribute multiplier:1.0f constant:0.0f];
    }
    [prevItem addConstraint:positionConstraint];
}

@end

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
    [self _setUpConstraintsForItem:item prevItem:prevItem isHorizontal:true];
    [self _setUpConstraintsForItem:item prevItem:prevItem isHorizontal:false];
}

- (void)_setUpConstraintsForItem:(UIView *)item prevItem:(UIView *)prevItem isHorizontal:(bool)isHorizontal {
    CGSize itemSize = item.frame.size;
    CGFloat itemSpan = isHorizontal ? itemSize.width : itemSize.height;
    
    NSLayoutAttribute spanAttribute = isHorizontal ? NSLayoutAttributeWidth : NSLayoutAttributeHeight;
    NSLayoutAttribute infAttribute = isHorizontal ? NSLayoutAttributeLeading : NSLayoutAttributeTop;
    NSLayoutAttribute supAttribute = isHorizontal ? NSLayoutAttributeTrailing : NSLayoutAttributeBottom;
    NSLayoutAttribute midAttribute = isHorizontal ? NSLayoutAttributeCenterX : NSLayoutAttributeCenterY;
    
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
        [item addConstraint:spanConstraint];
        
        boundConstraintRelation = NSLayoutRelationLessThanOrEqual;
    }
    
    NSLayoutConstraint *infConstraint = [NSLayoutConstraint
                                              constraintWithItem:prevItem
                                              attribute:infAttribute
                                              relatedBy:boundConstraintRelation
                                              toItem:item
                                              attribute:infAttribute
                                              multiplier:1.0f constant:0.0f];
    
    NSLayoutConstraint *supConstraint = [NSLayoutConstraint
                                              constraintWithItem:item
                                              attribute:supAttribute
                                              relatedBy:boundConstraintRelation
                                              toItem:prevItem
                                              attribute:supAttribute
                                              multiplier:1.0f constant:0.0f];
    
    [prevItem addConstraints:@[
        infConstraint,
        supConstraint,
    ]];
    
    NSLayoutConstraint *positionConstraint;
    if (self.alignment & JUNStackAlignmentMainAxisMin) {
        positionConstraint = [NSLayoutConstraint constraintWithItem:prevItem attribute:infAttribute relatedBy:NSLayoutRelationEqual toItem:item attribute:infAttribute multiplier:1.0f constant:0.0f];
    } else if (self.alignment & JUNStackAlignmentMainAxisCenter) {
        positionConstraint = [NSLayoutConstraint constraintWithItem:prevItem attribute:midAttribute relatedBy:NSLayoutRelationEqual toItem:item attribute:midAttribute multiplier:1.0f constant:0.0f];
    } else {
        positionConstraint = [NSLayoutConstraint constraintWithItem:prevItem attribute:supAttribute relatedBy:NSLayoutRelationEqual toItem:item attribute:supAttribute multiplier:1.0f constant:0.0f];
    }
    [prevItem addConstraint:positionConstraint];
}

@end

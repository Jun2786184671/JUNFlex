//
//  JUNZStack.m
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/28.
//

#import "JUNZStack.h"

@implementation JUNZStack
JUN_REGISTER_CLASS(@"zstack", [JUNStackProperty class]);

- (void)jun_setProperty:(__kindof JUNBaseProperty *)property {
//    if ([property isEqual:self.jun_property]) return;
    [super jun_setProperty:property];
    if (![property isKindOfClass:[JUNStackProperty class]]) return;
    [self _setUpItems];
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
    CGFloat axisAlign = isMainAxis ? self.mainAxisAlignment : self.crossAxisAlignment;
    
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

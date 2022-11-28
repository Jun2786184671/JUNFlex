//
//  JUNFlex.m
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/26.
//

#import "JUNLinearStack.h"

#import "UIView+JUNex4Flex.h"

#define IsHorizontal self.isHorizontal

#define JUNLayoutAttributeTop (IsHorizontal ? NSLayoutAttributeTop : NSLayoutAttributeLeading)
#define JUNLayoutAttributeBottom (IsHorizontal ? NSLayoutAttributeBottom : NSLayoutAttributeTrailing)
#define JUNLayoutAttributeLeading (IsHorizontal ? NSLayoutAttributeLeading : NSLayoutAttributeTop)
#define JUNLayoutAttributeTrailing (IsHorizontal ? NSLayoutAttributeTrailing : NSLayoutAttributeBottom)
#define JUNLayoutAttributeWidth (IsHorizontal ? NSLayoutAttributeWidth : NSLayoutAttributeHeight)
#define JUNLayoutAttributeHeight (IsHorizontal ? NSLayoutAttributeHeight : NSLayoutAttributeWidth)
#define JUNLayoutAttributeCenterY (IsHorizontal ? NSLayoutAttributeCenterY : NSLayoutAttributeCenterX)
#define JUNLayoutAttributeCenterX (IsHorizontal ? NSLayoutAttributeCenterX : NSLayoutAttributeCenterY)

#define jun_insetsTop (IsHorizontal ? self.insets.top : self.insets.left)
#define jun_insetsBottom (IsHorizontal ? self.insets.bottom : self.insets.right)
#define jun_insetsLeft (IsHorizontal ? self.insets.left : self.insets.top)
#define jun_insetsRight (IsHorizontal ? self.insets.right : self.insets.bottom)

#define jun_itemW(item) (IsHorizontal ? item.frame.size.width : item.frame.size.height)
#define jun_itemH(item) (IsHorizontal ? item.frame.size.height : item.frame.size.width)

@interface JUNLinearStack ()

@end

@implementation JUNLinearStack

- (instancetype)initWithItems:(NSArray<UIView *> *)items alignment:(JUNStackAlignment)alignment insets:(UIEdgeInsets)insets {
    if (self = [super initWithItems:items alignment:alignment insets:insets]) {
        [self _setUpItems];
    }
    return self;
}

- (void)_setUpItems {
    UIView *prevItem = nil;
    UIView *prevSizeBox = nil;
    for (UIView *item in self.items) {
        item.translatesAutoresizingMaskIntoConstraints = false;
        [item jun_validateFrame];
        [self addSubview:item];
        UIView *sizeBox = [self _createSizeBox];
        [self addSubview:sizeBox];
        [self _setUpConstraintsForItem:item andSizeBox:sizeBox prevItem:prevItem prevSizeBox:prevSizeBox];
        prevItem = item;
        prevSizeBox = sizeBox;
    }
    UIView *sizeBox = [self _createSizeBox];
    [self addSubview:sizeBox];
    [self _setUpConstraintsForItem:nil andSizeBox:sizeBox prevItem:prevItem prevSizeBox:prevSizeBox];
}

- (UIView *)_createSizeBox {
    UIView *sizeBox = [[UIView alloc] init];
    sizeBox.translatesAutoresizingMaskIntoConstraints = false;
    return sizeBox;
}

- (void)_setUpConstraintsForItem:(UIView *)item andSizeBox:(UIView *)sizeBox prevItem:(UIView *)prevItem prevSizeBox:(UIView *)prevSizeBox {
    [self _setUpMainAxisConstraintsForItem:item andSizeBox:sizeBox prevItem:prevItem prevSizeBox:prevSizeBox];
    [self _setUpCrossAxisConstraintsForItem:item andSizeBox:sizeBox];
}

- (void)_setUpMainAxisConstraintsForItem:(UIView *)item andSizeBox:(UIView *)sizeBox prevItem:(UIView *)prevItem prevSizeBox:(UIView *)prevSizeBox {
    [self _setUpMainAxisConstraintsForSizeBox:sizeBox prevItem:prevItem prevSizeBox:prevSizeBox];
    if (item != nil) {
        [self _setUpMainAxisConstraintsForItem:item sizeBox:sizeBox prevItem:prevItem];
    }
}

- (void)_setUpMainAxisConstraintsForSizeBox:(UIView *)sizeBox prevItem:(UIView *)prevItem prevSizeBox:(UIView *)prevSizeBox {
    if (prevItem == nil) { // first sizebox
        [self _setUpMainAxisConstraintsForFirstSizeBox:sizeBox];
    } else {
        [self addConstraint:
            [NSLayoutConstraint
             constraintWithItem:sizeBox
             attribute:JUNLayoutAttributeLeading
             relatedBy:NSLayoutRelationEqual
             toItem:prevItem
             attribute:JUNLayoutAttributeTrailing
             multiplier:1.0f constant:0.0f]
        ];
        if (prevItem == [self.items firstObject] && [self.items count] > 1) { // second sizebox
            [self _setUpRestMainAxisConstraintsForSecondSizeBox:sizeBox prevSizeBox:prevSizeBox];
        } else if (prevItem == [self.items lastObject]) { // last additional sizebox
            [self _setUpRestMainAxisConstraintsForLastSizeBox:sizeBox prevSizeBox:prevSizeBox];
        } else {
            [self _setUpRestMainAxisConstraintsForMedialSizeBox:sizeBox prevSizeBox:prevSizeBox];
        }
    }
}

- (void)_setUpMainAxisConstraintsForFirstSizeBox:(UIView *)sizeBox {
    [self addConstraint:
        [NSLayoutConstraint
         constraintWithItem:sizeBox
         attribute:JUNLayoutAttributeLeading
         relatedBy:NSLayoutRelationEqual
         toItem:self
         attribute:JUNLayoutAttributeLeading
         multiplier:1.0f
         constant:jun_insetsLeft]
    ];
    if (self.alignment & JUNStackAlignmentMainAxisMax) {
        [self addConstraint:
            [NSLayoutConstraint
             constraintWithItem:sizeBox
             attribute:JUNLayoutAttributeWidth
             relatedBy:NSLayoutRelationEqual
             toItem:nil
             attribute:NSLayoutAttributeNotAnAttribute
             multiplier:1.0f constant:0.0f]
        ];
    }
}

- (void)_setUpRestMainAxisConstraintsForSecondSizeBox:(UIView *)sizeBox prevSizeBox:(UIView *)prevSizeBox {
    if (self.alignment & JUNStackAlignmentMainAxisMax) return;
    CGFloat multiplier = 1.0f;
    if (self.alignment & JUNStackAlignmentMainAxisCenter) {
        multiplier = 2.0f;
    }
    [self addConstraint:
         [NSLayoutConstraint
          constraintWithItem:sizeBox
          attribute:JUNLayoutAttributeWidth
          relatedBy:NSLayoutRelationEqual
          toItem:prevSizeBox
          attribute:JUNLayoutAttributeWidth
          multiplier:multiplier constant:0.0f]
    ];
}

- (void)_setUpRestMainAxisConstraintsForLastSizeBox:(UIView *)sizeBox prevSizeBox:(UIView *)prevSizeBox {
    [self addConstraint:
        [NSLayoutConstraint
         constraintWithItem:sizeBox
         attribute:JUNLayoutAttributeTrailing
         relatedBy:NSLayoutRelationEqual
         toItem:self
         attribute:JUNLayoutAttributeTrailing
         multiplier:1.0f
         constant:-jun_insetsRight]
    ];
    CGFloat multiplier = 1.0f;
    if (self.alignment & JUNStackAlignmentMainAxisMax) {
        multiplier = 0.0f;
    } else if (self.alignment & JUNStackAlignmentMainAxisCenter) {
        multiplier = 0.5f;
    }
    [self addConstraint:
         [NSLayoutConstraint
          constraintWithItem:sizeBox
          attribute:JUNLayoutAttributeWidth
          relatedBy:NSLayoutRelationEqual
          toItem:prevSizeBox
          attribute:JUNLayoutAttributeWidth
          multiplier:multiplier constant:0.0f]
    ];
}

- (void)_setUpRestMainAxisConstraintsForMedialSizeBox:(UIView *)sizeBox prevSizeBox:(UIView *)prevSizeBox {
    [self addConstraint:
        [NSLayoutConstraint
         constraintWithItem:sizeBox
         attribute:JUNLayoutAttributeWidth
         relatedBy:NSLayoutRelationEqual
         toItem:prevSizeBox
         attribute:JUNLayoutAttributeWidth
         multiplier:1.0f constant:0.0f]
    ];
}

- (void)_setUpMainAxisConstraintsForItem:(UIView *)item sizeBox:(UIView *)sizeBox prevItem:(UIView *)prevItem {
    [self addConstraint:
        [NSLayoutConstraint
         constraintWithItem:item
         attribute:JUNLayoutAttributeLeading
         relatedBy:NSLayoutRelationEqual
         toItem:sizeBox
         attribute:JUNLayoutAttributeTrailing
         multiplier:1.0f constant:0.0f]
    ];
    [self _setUpRatioConstraintsForItem:item toPrevItem:prevItem];
    if ([item isKindOfClass:[JUNStack class]]) return;
    NSAssert(jun_itemW(item), @"item added to flex must have a valid length on main axis");
    NSLayoutConstraint *mainAxisLengthConstraint = [NSLayoutConstraint
                                      constraintWithItem:item
                                      attribute:JUNLayoutAttributeWidth
                                      relatedBy:NSLayoutRelationEqual
                                      toItem:nil
                                      attribute:NSLayoutAttributeNotAnAttribute
                                      multiplier:1.0f constant:jun_itemW(item)];
    mainAxisLengthConstraint.priority = UILayoutPriorityDefaultHigh;
    [self addConstraint:
         mainAxisLengthConstraint
    ];
}

- (void)_setUpRatioConstraintsForItem:(UIView *)item toPrevItem:(UIView *)prevItem {
    if (jun_itemW(item) == 0.0f || jun_itemW(prevItem) == 0.0f) return;
    [self addConstraint:
         [NSLayoutConstraint
          constraintWithItem:item
          attribute:JUNLayoutAttributeWidth
          relatedBy:NSLayoutRelationEqual
          toItem:prevItem
          attribute:JUNLayoutAttributeWidth
          multiplier:jun_itemW(item) / jun_itemW(prevItem)
          constant:0.0f]
    ];
}

- (void)_setUpCrossAxisConstraintsForItem:(UIView *)item andSizeBox:(UIView *)sizeBox {
    [self _setUpCrossAxisConstraintsForSizeBox:sizeBox];
    if (item == nil) return;
    if (jun_itemH(item) > 0.0f) {
        [self _setUpCrossAxisConstraintsForSpecifiedHeightItem:item];
    } else {
        [self _setUpCrossAxisConstraintsForNonSpecifiedHeightItem:item];
    }
    NSLayoutConstraint *axisMinConstraint = [NSLayoutConstraint
                                         constraintWithItem:self
                                         attribute:JUNLayoutAttributeTop
                                         relatedBy:NSLayoutRelationLessThanOrEqual
                                         toItem:item attribute:JUNLayoutAttributeTop
                                         multiplier:1.0f
                                         constant:-jun_insetsTop];
    axisMinConstraint.priority = UILayoutPriorityFittingSizeLevel;
    NSLayoutConstraint *axisMaxConstraint = [NSLayoutConstraint
                                          constraintWithItem:self
                                          attribute:JUNLayoutAttributeBottom
                                          relatedBy:NSLayoutRelationGreaterThanOrEqual
                                          toItem:item attribute:JUNLayoutAttributeBottom
                                          multiplier:1.0f
                                          constant:jun_insetsBottom];
    axisMaxConstraint.priority = UILayoutPriorityFittingSizeLevel;
    [self addConstraint:axisMaxConstraint];
    [self addConstraint:axisMinConstraint];
}

- (void)_setUpCrossAxisConstraintsForSizeBox:(UIView *)sizeBox {
    [self addConstraints:@[
        [NSLayoutConstraint
         constraintWithItem:sizeBox
         attribute:JUNLayoutAttributeTop
         relatedBy:NSLayoutRelationEqual
         toItem:self
         attribute:JUNLayoutAttributeTop
         multiplier:1.0f
         constant:jun_insetsTop],
        [NSLayoutConstraint
         constraintWithItem:sizeBox
         attribute:JUNLayoutAttributeBottom
         relatedBy:NSLayoutRelationEqual
         toItem:self
         attribute:JUNLayoutAttributeBottom
         multiplier:1.0f
         constant:-jun_insetsBottom],
    ]];
}

- (void)_setUpCrossAxisConstraintsForSpecifiedHeightItem:(UIView *)item {
    [self addConstraint:
         [NSLayoutConstraint
          constraintWithItem:item
          attribute:JUNLayoutAttributeHeight
          relatedBy:NSLayoutRelationEqual
          toItem:nil
          attribute:NSLayoutAttributeNotAnAttribute
          multiplier:1.0f
          constant:jun_itemH(item)]
    ];
    if (self.alignment & JUNStackAlignmentCrossAxisMin) {
        [self addConstraint:
             [NSLayoutConstraint
              constraintWithItem:item
              attribute:JUNLayoutAttributeTop
              relatedBy:NSLayoutRelationEqual
              toItem:self
              attribute:JUNLayoutAttributeTop
              multiplier:1.0f constant:jun_insetsTop]
        ];
    } else if (self.alignment & JUNStackAlignmentCrossAxisCenter) {
        [self addConstraint:
             [NSLayoutConstraint
              constraintWithItem:item
              attribute:JUNLayoutAttributeCenterY
              relatedBy:NSLayoutRelationEqual
              toItem:self
              attribute:JUNLayoutAttributeCenterY
              multiplier:1.0f constant:0.0f]
        ];
    } else {
        [self addConstraint:
             [NSLayoutConstraint
              constraintWithItem:item
              attribute:JUNLayoutAttributeBottom
              relatedBy:NSLayoutRelationEqual
              toItem:self
              attribute:JUNLayoutAttributeBottom
              multiplier:1.0f constant:-jun_insetsBottom]
        ];
    }
}

- (void)_setUpCrossAxisConstraintsForNonSpecifiedHeightItem:(UIView *)item {
    [self addConstraints:@[
        [NSLayoutConstraint
         constraintWithItem:item
         attribute:JUNLayoutAttributeTop
         relatedBy:NSLayoutRelationEqual
         toItem:self
         attribute:JUNLayoutAttributeTop
         multiplier:1.0f
         constant:jun_insetsTop],
        [NSLayoutConstraint
         constraintWithItem:item
         attribute:JUNLayoutAttributeBottom
         relatedBy:NSLayoutRelationEqual
         toItem:self
         attribute:JUNLayoutAttributeBottom
         multiplier:1.0f
         constant:-jun_insetsBottom],
    ]];
}

@end

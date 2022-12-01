//
//  JUNFlex.m
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/26.
//

#import "$LinearStack.h"
#import "JUNPadding.h"
#import "UIView+JUNex4Flex.h"

@implementation $LinearStack

- (instancetype)initWithItems:(NSArray<UIView *> *)items alignment:(CGPoint)alignment {
    if (self = [super initWithItems:items alignment:alignment]) {
        [self _addCrossHugConstraints];
        [self _setUpItems];
    }
    return self;
}

- (void)_addCrossHugConstraints {
    NSLayoutAttribute crossSpanAttribute = self.isHorizontal? NSLayoutAttributeHeight : NSLayoutAttributeWidth;

    NSLayoutConstraint *crossHugConstraint = [NSLayoutConstraint constraintWithItem:self attribute:crossSpanAttribute relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:0.0f];
    crossHugConstraint.priority = UILayoutPriorityDefaultHigh - 1;
    [self addConstraint:crossHugConstraint];
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
    bool isHorizontal = self.isHorizontal;
    
    CGSize itemSize = item.frame.size;
    CGFloat mainSpan = isHorizontal ? itemSize.width : itemSize.height;
    CGFloat mainAlign = self.alignment.x;
    CGFloat crossAlign = self.alignment.y;
    
    NSLayoutAttribute mainSpanAttribute = isHorizontal ? NSLayoutAttributeWidth : NSLayoutAttributeHeight;
    NSLayoutAttribute mainInfAttribute = isHorizontal ? NSLayoutAttributeLeading : NSLayoutAttributeTop;
    NSLayoutAttribute mainSupAttribute = isHorizontal ? NSLayoutAttributeTrailing : NSLayoutAttributeBottom;
//    NSLayoutAttribute mainMidAttribute = isHorizontal ? NSLayoutAttributeCenterX : NSLayoutAttributeCenterY;
    
    CGFloat crossSpan = isHorizontal ? itemSize.height : itemSize.width;
    
    NSLayoutAttribute crossSpanAttribute = isHorizontal ? NSLayoutAttributeHeight : NSLayoutAttributeWidth;
    NSLayoutAttribute crossInfAttribute = isHorizontal ? NSLayoutAttributeTop : NSLayoutAttributeLeading;
    NSLayoutAttribute crossSupAttribute = isHorizontal ? NSLayoutAttributeBottom : NSLayoutAttributeTrailing;
    NSLayoutAttribute crossMidAttribute = isHorizontal ? NSLayoutAttributeCenterY : NSLayoutAttributeCenterX;
    
    // set up common constraints for sizeboxes first
    [self addConstraints:@[
        [NSLayoutConstraint constraintWithItem:sizeBox attribute:crossSpanAttribute relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:CGFLOAT_MIN],
        [NSLayoutConstraint constraintWithItem:sizeBox attribute:crossMidAttribute relatedBy:NSLayoutRelationEqual toItem:self attribute:crossMidAttribute multiplier:1.0f constant:0.0f],
    ]];
    
    
    if (prevItem == nil) { // first item
        [self addConstraint:
            [NSLayoutConstraint constraintWithItem:sizeBox attribute:mainInfAttribute relatedBy:NSLayoutRelationEqual toItem:self attribute:mainInfAttribute multiplier:1.0f constant:0.0f]
        ];
        if (mainAlign > 0) { // make sizebox invisible
            [self addConstraints:@[
                [NSLayoutConstraint constraintWithItem:sizeBox attribute:mainSpanAttribute relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:0.0f],
            ]];
        }
    } else {
        
        [self addConstraint:
            [NSLayoutConstraint constraintWithItem:sizeBox attribute:mainInfAttribute relatedBy:NSLayoutRelationEqual toItem:prevItem attribute:mainSupAttribute multiplier:1.0f constant:0.0f]
        ];
        
        if (item == nil && prevItem == [self.items firstObject]) { // last additional sizebox when only have one item in stack
            [self addConstraints:@[
                [NSLayoutConstraint constraintWithItem:sizeBox attribute:mainSpanAttribute relatedBy:NSLayoutRelationEqual toItem:prevSizeBox attribute:mainSpanAttribute multiplier:1.0f constant:0.0f],
                [NSLayoutConstraint constraintWithItem:self attribute:mainSupAttribute relatedBy:NSLayoutRelationEqual toItem:sizeBox attribute:mainSupAttribute multiplier:1.0f constant:0.0f]
            ]];
            return;
        }
        
        if (prevItem == [self.items firstObject]) { // second item
            if (mainAlign == 0) { // sizebox span double to prevSizebox
                [self addConstraint:
                    [NSLayoutConstraint constraintWithItem:sizeBox attribute:mainSpanAttribute relatedBy:NSLayoutRelationEqual toItem:prevSizeBox attribute:mainSpanAttribute multiplier:2.0f constant:0.0f]
                ];
            } else if (mainAlign < 0) { // sizebox span equal to prevSizeBox
                [self addConstraint:
                    [NSLayoutConstraint constraintWithItem:sizeBox attribute:mainSpanAttribute relatedBy:NSLayoutRelationEqual toItem:prevSizeBox attribute:mainSpanAttribute multiplier:1.0f constant:0.0f]
                ];
            }
        } else if (item == nil) { // last additional sizebox
            [self addConstraint:
                [NSLayoutConstraint constraintWithItem:self attribute:mainSupAttribute relatedBy:NSLayoutRelationEqual toItem:sizeBox attribute:mainSupAttribute multiplier:1.0f constant:0.0f]
            ];
            if (mainAlign > 0) { // make sizebox invisible
                [self addConstraints:@[
                    [NSLayoutConstraint constraintWithItem:sizeBox attribute:mainSpanAttribute relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:0.0f],
                ]];
            } else if (mainAlign == 0) { // sizebox span half to prevSizebox
                [self addConstraints:@[
                    [NSLayoutConstraint constraintWithItem:sizeBox attribute:mainSpanAttribute relatedBy:NSLayoutRelationEqual toItem:prevSizeBox attribute:mainSpanAttribute multiplier:0.5f constant:0.0f],
                ]];
            } else { // sizebox span equal to prevSizebox
                [self addConstraints:@[
                    [NSLayoutConstraint constraintWithItem:sizeBox attribute:mainSpanAttribute relatedBy:NSLayoutRelationEqual toItem:prevSizeBox attribute:mainSpanAttribute multiplier:1.0f constant:0.0f],
                ]];
            }
            return;
        } else { // medial item and sizeboxes
            [self addConstraints:@[
                [NSLayoutConstraint constraintWithItem:sizeBox attribute:mainSpanAttribute relatedBy:NSLayoutRelationEqual toItem:prevSizeBox attribute:mainSpanAttribute multiplier:1.0f constant:0.0f],
            ]];
        }
    }
    // handle common constraints
    // main axis
    [self addConstraint:
        [NSLayoutConstraint constraintWithItem:item attribute:mainInfAttribute relatedBy:NSLayoutRelationEqual toItem:sizeBox attribute:mainSupAttribute multiplier:1.0f constant:0.0f]
    ];
    // main axis span
    if (mainSpan) {
        // add main span constraint
        NSLayoutConstraint *mainSpanConstraint = [NSLayoutConstraint
                                                  constraintWithItem:item
                                                  attribute:mainSpanAttribute
                                                  relatedBy:NSLayoutRelationEqual
                                                  toItem:nil
                                                  attribute:NSLayoutAttributeNotAnAttribute
                                                  multiplier:1.0f constant:mainSpan];
        mainSpanConstraint.priority = UILayoutPriorityDefaultHigh;
        [item addConstraints:@[
            mainSpanConstraint,
            [NSLayoutConstraint constraintWithItem:item attribute:mainSpanAttribute relatedBy:NSLayoutRelationLessThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:mainSpan],
        ]];
        // add main span ratio constraint to prevItem
        CGSize prevItemSize = prevItem.frame.size;
        CGFloat prevMainSpan = isHorizontal ? prevItemSize.width : prevItemSize.height;
        if (prevItem && prevMainSpan) {
            [self addConstraint:
                [NSLayoutConstraint constraintWithItem:item attribute:mainSpanAttribute relatedBy:NSLayoutRelationEqual toItem:prevItem attribute:mainSpanAttribute multiplier:(mainSpan / prevMainSpan) constant:0.0f]
            ];
        }
    }
    //  cross axis
    if (crossSpan) {
        NSLayoutConstraint *crossSpanConstraint = [NSLayoutConstraint
                                                  constraintWithItem:item
                                                  attribute:crossSpanAttribute
                                                  relatedBy:NSLayoutRelationEqual
                                                  toItem:nil
                                                  attribute:NSLayoutAttributeNotAnAttribute
                                                  multiplier:1.0f constant:crossSpan];
        crossSpanConstraint.priority = UILayoutPriorityDefaultHigh;
        [item addConstraints:@[
            crossSpanConstraint,
            [NSLayoutConstraint constraintWithItem:item attribute:crossSpanAttribute relatedBy:NSLayoutRelationLessThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:crossSpan],
        ]];
    } else {
        NSLayoutConstraint *crossSpanConstraint = [NSLayoutConstraint
                                                  constraintWithItem:item
                                                  attribute:crossSpanAttribute
                                                  relatedBy:NSLayoutRelationEqual
                                                  toItem:self
                                                  attribute:crossSpanAttribute
                                                  multiplier:1.0f constant:0.0f];
        
        if ([item isKindOfClass:[JUNPadding class]]) {
            crossSpanConstraint.priority = UILayoutPriorityFittingSizeLevel;
        } else {
            crossSpanConstraint.priority = UILayoutPriorityDefaultHigh;
        }
        [self addConstraint:crossSpanConstraint];
    }
    
    [self addConstraints:@[
        [NSLayoutConstraint constraintWithItem:item attribute:crossInfAttribute relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self attribute:crossInfAttribute multiplier:1.0f constant:0.0f],
        [NSLayoutConstraint constraintWithItem:self attribute:crossSupAttribute relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:item attribute:crossSupAttribute multiplier:1.0f constant:0.0f],
    ]];
    
    if (crossAlign < 0) {
        [self addConstraint:
            [NSLayoutConstraint constraintWithItem:item attribute:crossInfAttribute relatedBy:NSLayoutRelationEqual toItem:self attribute:crossInfAttribute multiplier:1.0f constant:0.0f]
        ];
    } else if (crossAlign > 0) {
        [self addConstraint:
            [NSLayoutConstraint constraintWithItem:self attribute:crossSupAttribute relatedBy:NSLayoutRelationEqual toItem:item attribute:crossSupAttribute multiplier:1.0f constant:0.0f]
        ];
    } else {
        [self addConstraint:
            [NSLayoutConstraint constraintWithItem:item attribute:crossMidAttribute relatedBy:NSLayoutRelationEqual toItem:self attribute:crossMidAttribute multiplier:1.0f constant:0.0f]
        ];
    }
    
}

@end

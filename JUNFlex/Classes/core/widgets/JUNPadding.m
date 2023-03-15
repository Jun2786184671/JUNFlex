//
//  JUNPadding.m
//  JUNFlex
//
//  Created by Jun Ma on 2022/12/1.
//

#import "JUNPadding.h"
#import "JUNPaddingProperty.h"

@implementation JUNPadding
JUN_REGISTER_CLASS(@"padding", [JUNPaddingProperty class]);

- (void)jun_setProperty:(__kindof JUNBaseProperty *)property {
//    if ([property isEqual:self.jun_property]) return;
    [super jun_setProperty:property];
    if (![property isKindOfClass:[JUNPaddingProperty class]]) return;
    JUNPaddingProperty *paddingProperty = property;
    [self addSubview:paddingProperty.childView];
    [self addConstraints:@[
        [NSLayoutConstraint constraintWithItem:paddingProperty.childView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0f constant:[paddingProperty.top floatValue]],
        [NSLayoutConstraint constraintWithItem:paddingProperty.childView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0f constant:-[paddingProperty.bottom floatValue]],
        [NSLayoutConstraint constraintWithItem:paddingProperty.childView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0f constant:[paddingProperty.left floatValue]],
        [NSLayoutConstraint constraintWithItem:paddingProperty.childView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:-[paddingProperty.right floatValue]],
    ]];
}

@end

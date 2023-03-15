//
//  JUNItem.m
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/29.
//

#import "JUNItem.h"
#import "JUNItemProperty.h"
#import "UIFont+JUNFlex_Private.h"
#import "UIColor+JUNFlex_Private.h"
#import <SDWebImage/SDWebImage.h>

@implementation JUNItem
JUN_REGISTER_CLASS(@"item", [JUNItemProperty class]);

- (void)jun_setProperty:(__kindof JUNBaseProperty *)property {
//    if ([property isEqual:self.jun_property]) return;
    [super jun_setProperty:property];
    if (![property isKindOfClass:[JUNItemProperty class]]) return;
    JUNItemProperty *itemProperty = property;
    
    if (itemProperty.align) {
        JUNAlignProperty *align = itemProperty.align;
        if (align.main) {
            self.contentHorizontalAlignment = [self getHorizontalAlignWithInt:[align.main intValue]];
        }
        if (align.cross) {
            self.contentVerticalAlignment = [self getVerticalAlignWithInt:[align.cross intValue]];
        }
    }
    
    if (itemProperty.text) {
        JUNTextProperty *text = itemProperty.text;
        if (text.string) {
            [self setTitle:text.string forState:UIControlStateNormal];
        }
        if (text.color) {
            [self setTitleColor:[UIColor jun_colorWithProperty:text.color] forState:UIControlStateNormal];
        }
        if (text.font) {
            self.titleLabel.font = [UIFont jun_fontWithProperty:text.font];
        }
    }
    
    if (itemProperty.image) {
        NSURL *url = [NSURL URLWithString:itemProperty.image];
        bool isUrl = url.scheme.length && url.host.length && url.path.length;
        if (isUrl) {
            [self sd_setBackgroundImageWithURL:url forState:UIControlStateNormal placeholderImage:nil];
        } else {
            UIImage *image = [UIImage imageNamed:itemProperty.image];
            [self setBackgroundImage:image forState:UIControlStateNormal];
        }
    }
    
    if (itemProperty.action) {
        JUNActionProperty *action = itemProperty.action;
        if (action.target && action.selector) {
            [self addTarget:action.target action:NSSelectorFromString(action.selector) forControlEvents:UIControlEventTouchUpInside];
        }
    }
}

#pragma mark - Private

- (UIControlContentHorizontalAlignment)getHorizontalAlignWithInt:(int)intValue {
    UIControlContentHorizontalAlignment res = 0;
    if (intValue < 0) {
        if (@available(iOS 11.0, *)) {
            res = UIControlContentHorizontalAlignmentLeading;
        } else {
            res = UIControlContentHorizontalAlignmentLeft;
        }
    } else if (intValue == 0) {
        res = UIControlContentHorizontalAlignmentCenter;
    } else if (intValue > 0) {
        if (@available(iOS 11.0, *)) {
            res = UIControlContentHorizontalAlignmentTrailing;
        } else {
            res = UIControlContentHorizontalAlignmentRight;
        }
    }
    return res;
}

- (UIControlContentVerticalAlignment)getVerticalAlignWithInt:(int)intValue {
    UIControlContentVerticalAlignment res = 0;
    if (intValue < 0) {
        res = UIControlContentVerticalAlignmentTop;
    } else if (intValue == 0) {
        res = UIControlContentVerticalAlignmentCenter;
    } else if (intValue > 0) {
        res = UIControlContentVerticalAlignmentBottom;
    }
    return res;
}

@end

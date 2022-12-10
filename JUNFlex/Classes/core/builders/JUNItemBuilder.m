//
//  JUNItemBuilder.m
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/29.
//

#import <SDWebImage/SDWebImage.h>
#import "JUNAbstractBuilder+Private.h"
#import "JUNItemBuilder.h"
#import "JUNItem.h"

#define JUNItemDefaultTextColor [UIColor blackColor]
#define JUNItemDefaultTextFontSize 20
#define JUNItemDefaultTextFont [UIFont systemFontOfSize:JUNItemDefaultTextFontSize]

@interface JUNItemBuilder ()

@property(nonatomic, strong) JUNItem *item;

@end

@implementation JUNItemBuilder

+ (void)load {
    [super load];
}

+ (NSString *)type {
    return @"item";
}

- (id)product {
    return self.item;
}

- (JUNItem *)item {
    if (_item == nil) {
        _item = [[JUNItem alloc] init];
    }
    return _item;
}

- (JUNItemBuilder * _Nonnull (^)(int, int))align {
    return ^(int mainAxisAlignment, int crossAxisAlignment) {
        UIControlContentHorizontalAlignment hAlignment = 0;
        if (mainAxisAlignment < 0) {
            if (@available(iOS 11.0, *)) {
                hAlignment = UIControlContentHorizontalAlignmentLeading;
            } else {
                hAlignment = UIControlContentHorizontalAlignmentLeft;
            }
        } else if (mainAxisAlignment == 0) {
            hAlignment = UIControlContentHorizontalAlignmentCenter;
        } else if (mainAxisAlignment > 0) {
            if (@available(iOS 11.0, *)) {
                hAlignment = UIControlContentHorizontalAlignmentTrailing;
            } else {
                hAlignment = UIControlContentHorizontalAlignmentRight;
            }
        }
        [self.item setContentHorizontalAlignment:hAlignment];
        
        UIControlContentVerticalAlignment vAlignment = 0;
        if (crossAxisAlignment < 0) {
            vAlignment = UIControlContentVerticalAlignmentTop;
        } else if (crossAxisAlignment == 0) {
            vAlignment = UIControlContentVerticalAlignmentCenter;
        } else if (crossAxisAlignment > 0) {
            vAlignment = UIControlContentVerticalAlignmentBottom;
        }
        [self.item setContentVerticalAlignment:vAlignment];
        return self;
    };
}

- (JUNItemBuilder * _Nonnull (^)(NSString * _Nonnull, UIFont * _Nullable, UIColor * _Nullable))text {
    return ^(NSString *text, UIFont * _Nullable font, UIColor * _Nullable color) {
        [self.item setTitle:text forState:UIControlStateNormal];
        [self.item setTitleColor:color ? color : JUNItemDefaultTextColor forState:UIControlStateNormal];
        self.item.titleLabel.font = font ? font : JUNItemDefaultTextFont;
        return self;
    };
}

- (JUNItemBuilder * _Nonnull (^)(NSString * _Nonnull))image {
    return ^(NSString *nameOrURL) {
        NSURL *URL = [NSURL URLWithString:nameOrURL];
        bool isURL = URL.scheme.length && URL.host.length && URL.path.length;
        if (isURL) {
            [self.item sd_setBackgroundImageWithURL:URL forState:UIControlStateNormal placeholderImage:nil];
        } else {
            UIImage *image = [UIImage imageNamed:nameOrURL];
            [self.item setBackgroundImage:image forState:UIControlStateNormal];
        }
        return self;
    };
}

- (JUNItemBuilder * _Nonnull (^)(id _Nonnull, SEL _Nonnull))onTap {
    return ^(id target, SEL selector) {
        [self.item addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
        return self;
    };
}

- (UIView *)buildWithDictionary:(NSDictionary *)dict {
    [super buildWithDictionary:dict];
    [self _configContentAlignmentWithDictionary:dict];
    [self _configTextWithDictionary:dict];
    [self _configImageWithDictionary:dict];
    return self.EOB;
}

- (void)_configContentAlignmentWithDictionary:(NSDictionary *)dict {
    id contentAlignment = dict[@"align"];
    if (contentAlignment == nil) return;
    NSAssert([contentAlignment isKindOfClass:[NSDictionary class]], @"unexpected contentAlignment format");
    id hAlign = [contentAlignment valueForKey:@"main"];
    int hAlignRaw = 0;
    if ([hAlign isKindOfClass:[NSString class]]) {
        if ([hAlign isEqualToString:@"min"]) {
            hAlignRaw = -1;
        } else if ([hAlign isEqualToString:@"center"]) {
            hAlignRaw = 0;
        } else if ([hAlign isEqualToString:@"max"]) {
            hAlignRaw = 1;
        } else {
            hAlignRaw = [self _intFromValue:hAlign];
        }
    } else {
        hAlignRaw = [self _intFromValue:hAlign];
    }
    id vAlign = [contentAlignment valueForKey:@"cross"];
    int vAlignRaw = 0;
    if ([vAlign isKindOfClass:[NSString class]]) {
        if ([vAlign isEqualToString:@"min"]) {
            vAlignRaw = -1;
        } else if ([vAlign isEqualToString:@"center"]) {
            vAlignRaw = 0;
        } else if ([vAlign isEqualToString:@"max"]) {
            vAlignRaw = 1;
        } else {
            vAlignRaw = [self _intFromValue:vAlign];
        }
    } else {
        vAlignRaw = [self _intFromValue:vAlign];
    }
    self.align(hAlignRaw, vAlignRaw);
}

- (void)_configTextWithDictionary:(NSDictionary *)dict {
    id text = dict[@"text"];
    if (text == nil) return;
    if ([text isKindOfClass:[NSString class]]) {
        self.text(text, JUNItemDefaultTextFont, JUNItemDefaultTextColor);
    } else if ([text isKindOfClass:[NSDictionary class]]) {
        // text string
        NSString *string = [self _stringFromValue:[text valueForKey:@"string"]];
        
        // text font
        UIFont *font = [self _fontFromValue:[text valueForKey:@"font"]];
        
        // text color
        UIColor *color = [self _colorFromValue:[text valueForKey:@"color"]];
        self.text(string, font ? font : JUNItemDefaultTextFont, color ? color : JUNItemDefaultTextColor);
    } else {
        NSAssert(false, @"unexpected text format");
    }
}

- (void)_configImageWithDictionary:(NSDictionary *)dict {
    id image = dict[@"image"];
    if (image == nil) return;
    self.image([self _stringFromValue:image]);
}

- (UIFont *)_fontFromValue:(id)fontValue {
    UIFont *font = nil;
    if ([fontValue isKindOfClass:[NSDictionary class]]) {
        NSString *fontName = [self _stringFromValue:[fontValue valueForKey:@"name"]];
        CGFloat fontSize = [self _floatFromValue:[fontValue valueForKey:@"size"]];
        if (!fontSize) {
            fontSize = JUNItemDefaultTextFontSize;
        }
        if (fontName) {
            font = [UIFont fontWithName:fontName size:fontSize];
        } else {
            font = [UIFont systemFontOfSize:fontSize];
        }
    } else {
        CGFloat fontSize = [self _floatFromValue:fontValue];
        font = [UIFont systemFontOfSize:fontSize ? fontSize : JUNItemDefaultTextFontSize];
    }
    return font ? font : JUNItemDefaultTextFont;
}

@end

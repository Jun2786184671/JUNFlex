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

- (JUNItemBuilder * _Nonnull (^)(UIControlContentHorizontalAlignment, UIControlContentVerticalAlignment))contentAlign {
    return ^(UIControlContentHorizontalAlignment h, UIControlContentVerticalAlignment v) {
        [self.item setContentHorizontalAlignment:h];
        [self.item setContentVerticalAlignment:v];
        return self;
    };
}

- (JUNItemBuilder * _Nonnull (^)(NSString * _Nonnull, CGFloat, UIColor * _Nonnull))text {
    return ^(NSString *text, CGFloat fontSize, UIColor *color) {
        [self.item setTitle:text forState:UIControlStateNormal];
        [self.item setTitleColor:color forState:UIControlStateNormal];
        self.item.titleLabel.font = [UIFont systemFontOfSize:fontSize];
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
    id contentAlignment = dict[@"content_align"];
    if (contentAlignment == nil) return;
    NSAssert([contentAlignment isKindOfClass:[NSDictionary class]], @"unexpected contentAlignment format");
    id hAlign = [contentAlignment valueForKey:@"main"];
    UIControlContentHorizontalAlignment hAlignRaw = 0;
    if ([hAlign isKindOfClass:[NSString class]]) {
        if ([hAlign isEqualToString:@"center"]) {
            hAlignRaw = UIControlContentHorizontalAlignmentCenter;
        } else if ([hAlign isEqualToString:@"min"]) {
            if (@available(iOS 11.0, *)) {
                hAlignRaw = UIControlContentHorizontalAlignmentLeading;
            } else {
                hAlignRaw = UIControlContentHorizontalAlignmentLeft;
            }
        } else if ([hAlign isEqualToString:@"max"]) {
            if (@available(iOS 11.0, *)) {
                hAlignRaw = UIControlContentHorizontalAlignmentTrailing;
            } else {
                hAlignRaw = UIControlContentHorizontalAlignmentRight;
            }
        } else if ([hAlign isEqualToString:@"fill"]) {
            hAlignRaw = UIControlContentHorizontalAlignmentFill;
        } else {
            hAlignRaw = [self _intFromValue:hAlign];
        }
    } else {
        hAlignRaw = [self _intFromValue:hAlign];
    }
    id vAlign = [contentAlignment valueForKey:@"cross"];
    UIControlContentVerticalAlignment vAlignRaw = 0;
    if ([vAlign isKindOfClass:[NSString class]]) {
        if ([vAlign isEqualToString:@"center"]) {
            vAlignRaw = UIControlContentVerticalAlignmentCenter;
        } else if ([vAlign isEqualToString:@"min"]) {
            vAlignRaw = UIControlContentVerticalAlignmentTop;
        } else if ([vAlign isEqualToString:@"max"]) {
            vAlignRaw = UIControlContentVerticalAlignmentBottom;
        } else if ([vAlign isEqualToString:@"fill"]) {
            vAlignRaw = UIControlContentVerticalAlignmentFill;
        } else {
            vAlignRaw = [self _intFromValue:vAlign];
        }
    } else {
        vAlignRaw = [self _intFromValue:vAlign];
    }
    self.contentAlign(hAlignRaw, vAlignRaw);
}

- (void)_configTextWithDictionary:(NSDictionary *)dict {
    id text = dict[@"text"];
    if (text == nil) return;
    CGFloat defaultFontSize = 20;
    UIColor *defaultColor = [UIColor blackColor];
    if ([text isKindOfClass:[NSString class]]) {
        self.text(text, defaultFontSize, defaultColor);
    } else if ([text isKindOfClass:[NSDictionary class]]) {
        NSString *string = [self _stringFromValue:[text valueForKey:@"string"]];
        CGFloat fontSize = [self _floatFromValue:[text valueForKey:@"font"]];
        UIColor *color = [self _colorFromValue:[text valueForKey:@"color"]];
        self.text(string, fontSize ? fontSize : defaultFontSize, color ? color : defaultColor);
    } else {
        NSAssert(false, @"unexpected text format");
    }
}

- (void)_configImageWithDictionary:(NSDictionary *)dict {
    id image = dict[@"image"];
    if (image == nil) return;
    self.image([self _stringFromValue:image]);
}

@end

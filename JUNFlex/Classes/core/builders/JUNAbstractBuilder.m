//
//  JUNAbstractBuilder.m
//  JUNFlex
//
//  Created by Jun Ma on 2022/12/1.
//

#import "JUNAbstractBuilder.h"
#import "UIView+JUNFlex.h"
#import "JUNJSONSerializer.h"
#import "UIColor+JUNFlex_Private.h"

@interface JUNAbstractBuilder ()

/// serialize identifier in json
@property(class, nonatomic, readonly) NSString *type;
@property(nonatomic, readonly) UIView *product;

@end

@implementation JUNAbstractBuilder

@dynamic type, product;

+ (void)load {
    if ([self respondsToSelector:@selector(type)]) {
        [JUNJSONSerializer sharedInstance].builderMapper[self.type] = [self class];
    }
}

- (id _Nonnull (^)(NSString * _Nonnull))ID {
    return ^(NSString *identifier) {
        self.product.accessibilityIdentifier = identifier;
        return self;
    };
}

- (id  _Nonnull (^)(id _Nonnull))data {
    return ^(id data) {
        if ([self.product respondsToSelector:@selector(setJun_data:)]) {
            [self.product performSelector:@selector(setJun_data:) withObject:data];
        }
        return self;
    };
}

- (id _Nonnull (^)(UIColor *))color {
    return ^(UIColor *color) {
        self.product.backgroundColor = color;
        return self;
    };
}

- (id _Nonnull (^)(CGFloat))alpha {
    return ^(CGFloat alpha) {
        self.product.alpha = alpha;
        return self;
    };
}

- (id _Nonnull (^)(CGFloat))radius {
    return ^(CGFloat radius) {
        self.product.layer.cornerRadius = radius;
        return self;
    };
}

- (id  _Nonnull (^)(CGFloat, UIColor * _Nonnull))border {
    return ^(CGFloat width, UIColor *color) {
        self.product.layer.borderWidth = width;
        self.product.layer.borderColor = color.CGColor;
        return self;
    };
}

- (id _Nonnull (^)(bool))maskBounds {
    return ^(bool maskBounds) {
        self.product.layer.masksToBounds = maskBounds;
        return self;
    };
}

- (id _Nonnull (^)(CGFloat))width {
    return ^(CGFloat width) {
        NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:self.product attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:width];
        widthConstraint.priority = UILayoutPriorityDefaultHigh;
        [self.product addConstraint:widthConstraint];
        CGRect frame = self.product.frame;
        frame.size.width = width;
        self.product.frame = frame;
        return self;
    };
}

- (id _Nonnull (^)(CGFloat))height {
    return ^(CGFloat height) {
        NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self.product attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:height];
        heightConstraint.priority = UILayoutPriorityDefaultHigh;
        [self.product addConstraint:heightConstraint];
        CGRect frame = self.product.frame;
        frame.size.height = height;
        self.product.frame = frame;
        return self;
    };
}

- (id  _Nonnull (^)(CGFloat, CGFloat))size {
    return ^(CGFloat width, CGFloat height) {
        self.width(width);
        self.height(height);
        return self;
    };
}

- (id)EOB {
    return self.product;
}

- (UIView *)buildWithDictionary:(NSDictionary *)dict {
    [dict enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, id  _Nonnull value, BOOL * _Nonnull stop) {
        if ([key isEqualToString:@"id"]) {
            self.ID([self _stringFromValue:value]);
        } else if ([key isEqualToString:@"data"]) {
            self.data(value);
        } else if ([key isEqualToString:@"color"]) {
            self.color([self _colorFromValue:value]);
        } else if ([key isEqualToString:@"alpha"]) {
            self.alpha([self _floatFromValue:value]);
        } else if ([key isEqualToString:@"radius"]) {
            self.radius([self _floatFromValue:value]);
        } else if ([key isEqualToString:@"border"]) {
            NSAssert([value isKindOfClass:[NSDictionary class]], @"unexpected border format");
            CGFloat width = [self _floatFromValue:[value valueForKey:@"width"]];
            UIColor *color = [self _colorFromValue:[value valueForKey:@"color"]];
            self.border(width, color);
        } else if ([key isEqualToString:@"mask_bounds"]) {
            self.maskBounds([self _boolFromValue:value]);
        } else if ([key isEqualToString:@"width"]) {
            self.width([self _floatFromValue:value]);
        } else if ([key isEqualToString:@"height"]) {
            self.height([self _floatFromValue:value]);
        } else if ([key isEqualToString:@"size"]) {
            NSAssert([value isKindOfClass:[NSDictionary class]], @"unexpected size format");
            CGFloat width = [self _floatFromValue:[value valueForKey:@"width"]];
            CGFloat height = [self _floatFromValue:[value valueForKey:@"height"]];
            self.size(width, height);
        }
    }];
    return self.EOB;
}

- (NSString *)_stringFromValue:(id)value {
    if (value == nil) return nil;
    if ([value isKindOfClass:[NSString class]]) {
        return value;
    } else if ([value isKindOfClass:[NSNumber class]]) {
        return [value stringValue];
    }
    return [value description];
}

- (bool)_boolFromValue:(id)boolValue {
    if (boolValue == nil) return false;
    if ([boolValue isKindOfClass:[NSString class]]) {
        boolValue = [boolValue uppercaseString];
        if ([boolValue isEqualToString:@"TRUE"] || [boolValue isEqualToString:@"YES"]) {
            return true;
        } else if ([boolValue isEqualToString:@"FALSE"] || [boolValue isEqualToString:@"NO"]) {
            return false;
        }
        return [boolValue boolValue];
    } else if ([boolValue isKindOfClass:[NSNumber class]]) {
        return [boolValue boolValue];
    }
    NSAssert(false, @"unexpected bool format");
    return false;
}

- (int)_intFromValue:(id)value {
    if (value == nil) return 0;
    NSAssert([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]], @"unexpected int format");
    return [value intValue];
}

- (CGFloat)_floatFromValue:(id)value {
    if (value == nil) return 0.0f;
    NSAssert([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]], @"unexpected float format");
    return [value floatValue];
}

- (UIColor *)_colorFromValue:(id)value {
    if (value == nil) return nil;
    if ([value isKindOfClass:[NSString class]]) {
        return [self _colorFromString:value];
    } else if ([value isKindOfClass:[NSNumber class]]) {
        uint32_t hex = [value unsignedIntValue];
        return [UIColor jun_colorWithRGBa:hex];
    }
    NSAssert(false, @"unexpected color format");
    return nil;
}

- (UIColor *)_colorFromString:(NSString *)colorStr {
    SEL colorSEL = NSSelectorFromString([colorStr stringByAppendingString:@"Color"]);
    if ([[UIColor class] respondsToSelector:colorSEL]) {
        return [[UIColor class] performSelector:colorSEL];
    }
    if ([colorStr hasPrefix:@"#"]) {
        colorStr = [colorStr stringByReplacingCharactersInRange:[colorStr rangeOfString:@"#"] withString:@""];
    }
    uint32_t hex = 0;
    NSScanner *scanner = [NSScanner scannerWithString:colorStr];
    [scanner scanHexInt:&hex];
    return [UIColor jun_colorWithRGBa:hex];
}

@end

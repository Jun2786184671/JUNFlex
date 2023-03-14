//
//  UIColor+JUNFlex_Private.m
//  JUNFlex
//
//  Created by Jun Ma on 2023/3/7.
//

#import "UIColor+JUNFlex_Private.h"
#import "JUNColorValueRGBA.h"
#import "JUNColorValueHSBA.h"
#import "JUNColorValueWA.h"

@implementation UIColor (JUNFlex_Private)

+ (instancetype)jun_colorWithProperty:(JUNColorProperty *)property {
    if (property.color) return property.color;
    NSParameterAssert(property.space && property.value);
    if (!property.space || !property.value) return [UIColor whiteColor];
    CGFloat a = property.value.a;
    if ([property.space isEqualToString:JUNColorSpaceRGBA]) {
        JUNColorValueRGBA *rgba = property.value;
        CGFloat r = rgba.r / 255.0f;
        CGFloat g = rgba.g / 255.0f;
        CGFloat b = rgba.b / 255.0f;
        return [UIColor colorWithRed:r green:g blue:b alpha:a];
    } else if ([property.space isEqualToString:JUNColorSpaceHSBA]) {
        JUNColorValueHSBA *hsba = property.value;
        CGFloat h = hsba.h / 360.0f;
        CGFloat s = hsba.s;
        CGFloat b = hsba.b;
        return [UIColor colorWithHue:h saturation:s brightness:b alpha:a];
    } else if ([property.space isEqualToString:JUNColorSpaceWA]) {
        JUNColorValueWA *wa = property.value;
        CGFloat w = wa.w;
        return [UIColor colorWithWhite:w alpha:a];
    }
    NSParameterAssert(false);
    return [UIColor whiteColor];
}

+ (instancetype)jun_colorWithHexString:(NSString *)hexString {
    if ([hexString hasPrefix:@"#"]) {
        hexString = [hexString substringFromIndex:1];
    } else if ([hexString hasPrefix:@"0x"]) {
        hexString = [hexString substringFromIndex:2];
    }
    uint32_t hex;
    NSScanner* scanner = [NSScanner scannerWithString:hexString];
    [scanner scanHexInt:&hex];
    CGFloat a = 1.0f;
    if (hexString.length == 8) {
        a = (hex & 0xff) / 255.0f;
        hex >>= 8;
    }
    CGFloat b = (hex & 0x0000ff) / 255.0f;
    CGFloat g = ((hex & 0x00ff00) >> 8) / 255.0f;
    CGFloat r = ((hex & 0xff0000) >> 16) / 255.0f;
    return [UIColor colorWithRed:r green:g blue:b alpha:a];
}

@end

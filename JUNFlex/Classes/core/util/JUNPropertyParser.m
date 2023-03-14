//
//  JUNBuildParser.m
//  JUNFlex
//
//  Created by Jun Ma on 2023/3/12.
//

#import "JUNPropertyParser.h"
#import "UIColor+JUNFlex_Private.h"
#import "JUNSizeProperty.h"

@implementation JUNPropertyParser

+ (instancetype)sharedParser {
    static JUNPropertyParser *parser;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        parser = [[self alloc] init];
    });
    return parser;
}

- (BOOL)isStringColorHexString:(NSString *)string {
    return [string hasPrefix:@"#"] || [string hasPrefix:@"0x"];
}

- (JUNColorProperty * _Nullable)parseColorPropertyWithValue:(id)value {
    UIColor *color;
    if ([value isKindOfClass:[NSString class]]) {
        color = [UIColor jun_colorWithHexString:value];
    } else if ([value isKindOfClass:[UIColor class]]) {
        color = value;
    } else {
        NSParameterAssert(false);
        return nil;
    }
    return [[JUNColorProperty alloc] initWithColor:color];
}

- (JUNFontProperty * _Nullable)parseFontPropertyWithValue:(id)value {
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        return [[JUNFontProperty alloc] initWithFontSize:[value floatValue]];
    } else if ([value isKindOfClass:[UIFont class]]) {
        return [[JUNFontProperty alloc] initWithFont:value];
    } else {
        NSParameterAssert(false);
        return nil;
    }
}

- (NSNumber * _Nullable)parseFloatWithValue:(id)value {
    if ([value isKindOfClass:[NSNumber class]]) {
        return value;
    } else if ([value isKindOfClass:[NSString class]]) {
        if ([value isEqualToString:JUNSizePropertyMax]) {
            return @CGFLOAT_MAX;
        } else if ([value isEqualToString:JUNSizePropertyMin]) {
            return @0.0f;
        } else {
            return [NSNumber numberWithFloat:[value floatValue]];
        }
    } else {
        NSParameterAssert(false);
        return nil;
    }
}

- (NSNumber * _Nullable)parseBoolWithValue:(id)value {
    if ([value isKindOfClass:[NSNumber class]]) {
        return value;
    } else if ([value isKindOfClass:[NSString class]]) {
        if ([[value capitalizedString] hasPrefix:@"T"] || [[value capitalizedString] hasPrefix:@"Y"]) {
            return @true;
        } else if ([[value capitalizedString] hasPrefix:@"F"] || [[value capitalizedString] hasPrefix:@"N"]) {
            return @false;
        } else {
            return @false;
        }
    } else {
        NSParameterAssert(false);
        return nil;
    }
}

@end

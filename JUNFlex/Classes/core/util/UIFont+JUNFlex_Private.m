//
//  UIFont+JUNFlex_Private.m
//  JUNFlex
//
//  Created by Jun Ma on 2022/12/12.
//

#import "UIFont+JUNFlex_Private.h"

static NSString * const JUNSystemFontFamilyName = @".AppleSystemUIFont";
static NSString * const JUNSystemFontRegular = @".SFUI-Regular";
static NSString * const JUNSystemFontBold = @".SFUI-Semibold";
static NSString * const JUNSystemFontItalic = @".SFUI-RegularItalic";

@implementation UIFont (JUNFlex_Private)

+ (instancetype)jun_fontWithProperty:(JUNFontProperty *)property {
    if (property.font) return property.font;
    UIFont *defaultFont = [UIFont systemFontOfSize:14];
    CGFloat fontSize = property.size ? [property.size floatValue] : defaultFont.pointSize;
    NSParameterAssert(!(property.family == nil ^ property.name == nil));
    if ([property.family isEqualToString:JUNSystemFontFamilyName]) {
        if ([property.name isEqualToString:JUNSystemFontRegular]) {
            return [UIFont systemFontOfSize:fontSize];
        } else if ([property.name isEqualToString:JUNSystemFontBold]) {
            return [UIFont boldSystemFontOfSize:fontSize];
        } else if ([property.name isEqualToString:JUNSystemFontItalic]) {
            return [UIFont italicSystemFontOfSize:fontSize];
        } else {
            NSParameterAssert(false);
            return [UIFont systemFontOfSize:fontSize];
        }
    } else {
        NSString *fontName = property.name ?: defaultFont.fontName;
        return [UIFont fontWithName:fontName size:fontSize];
    }
}

@end

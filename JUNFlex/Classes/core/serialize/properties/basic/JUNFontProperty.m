//
//  JUNFontProperties.m
//  JUNFlexTool
//
//  Created by Jun Ma on 2022/12/10.
//

#import "JUNFontProperty.h"
#import <MJExtension/NSObject+MJKeyValue.h>

@interface JUNFontProperty ()

@property(nonatomic, strong) UIFont *font;

@end

@implementation JUNFontProperty

+ (NSMutableArray *)orderedKeys {
    return [NSMutableArray arrayWithArray:@[
        NSStringFromSelector(@selector(family)),
        NSStringFromSelector(@selector(name)),
        NSStringFromSelector(@selector(size)),
    ]];
}

+ (NSArray *)mj_ignoredPropertyNames {
    return @[
        NSStringFromSelector(@selector(font)),
    ];
}

- (instancetype)initWithFont:(UIFont *)font {
    if (self = [super init]) {
        self.font = font;
        self.family = font.familyName;
        self.name = font.fontName;
        self.size = @(font.pointSize);
    }
    return self;
}

- (instancetype)initWithFontSize:(CGFloat)fontSize {
    if (self = [super init]) {
        UIFont *defaultFont = [UIFont systemFontOfSize:14];
        self.font = [UIFont fontWithName:defaultFont.fontName size:fontSize];
        self.size = @(fontSize);
    }
    return self;
}

@end

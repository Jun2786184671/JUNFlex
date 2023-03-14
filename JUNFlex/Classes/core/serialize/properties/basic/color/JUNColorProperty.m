//
//  JUNColorProperty.m
//  JUNFlex
//
//  Created by Jun Ma on 2023/3/12.
//

#import "JUNColorProperty.h"
#import "JUNColorValueRGBA.h"
#import "JUNColorValueHSBA.h"
#import "JUNColorValueWA.h"
#import "UIColor+JUNFlex_Private.h"
#import <MJExtension/NSObject+MJKeyValue.h>

JUNColorSpace const JUNColorSpaceRGBA = @"rgba";
JUNColorSpace const JUNColorSpaceHSBA = @"hsba";
JUNColorSpace const JUNColorSpaceWA = @"wa";

@interface JUNColorProperty ()

@property(nonatomic, strong) UIColor *color;

@end

@implementation JUNColorProperty

+ (NSMutableArray<NSString *> *)orderedKeys {
    return [NSMutableArray arrayWithArray:@[
        NSStringFromSelector(@selector(space)),
        NSStringFromSelector(@selector(value)),
    ]];
}

+ (NSArray *)mj_ignoredPropertyNames {
    return @[
        NSStringFromSelector(@selector(color)),
        NSStringFromSelector(@selector(value)),
    ];
}

- (void)mj_didConvertToObjectWithKeyValues:(NSDictionary *)keyValues {
    NSDictionary *value = keyValues[NSStringFromSelector(@selector(value))];
    Class valueCls = [[self class] getValueClassWithSpace:self.space];
    self.value = [valueCls mj_objectWithKeyValues:value];
}

- (void)mj_objectDidConvertToKeyValues:(NSMutableDictionary *)keyValues {
    NSParameterAssert(self.value);
    keyValues[NSStringFromSelector(@selector(value))] = [self.value mj_keyValues];
}

#pragma mark - Constructors

- (instancetype)initWithColor:(UIColor *)color {
    if (self = [super init]) {
        self.color = color;
        CGFloat r, g, b, a, h, s, w;
        if ([color getRed:&r green:&g blue:&b alpha:&a]) {
            self.space = JUNColorSpaceRGBA;
            JUNColorValueRGBA *value = [[JUNColorValueRGBA alloc] init];
            value.r = (uint8_t)(r * 255);
            value.g = (uint8_t)(g * 255);
            value.b = (uint8_t)(b * 255);
            self.value = value;
        } else if ([color getHue:&h saturation:&s brightness:&b alpha:&a]) {
            self.space = JUNColorSpaceHSBA;
            JUNColorValueHSBA *value = [[JUNColorValueHSBA alloc] init];
            value.h = h * 360;
            value.s = s;
            value.b = b;
            self.value = value;
        }
        else if ([color getWhite:&w alpha:&a]) {
            self.space = JUNColorSpaceWA;
            JUNColorValueWA *value = [[JUNColorValueWA alloc] init];
            value.w = w;
            self.value = value;
        } else {
            NSParameterAssert(false);
        }
        self.value.a = a;
    }
    return self;
}

#pragma mark - Private

+ (Class)getValueClassWithSpace:(NSString *)space {
    if ([space isEqualToString:JUNColorSpaceRGBA]) {
        return [JUNColorValueRGBA class];
    } else if ([space isEqualToString:JUNColorSpaceHSBA]) {
        return [JUNColorValueHSBA class];
    } else if ([space isEqualToString:JUNColorSpaceWA]) {
        return [JUNColorValueWA class];
    }
    return nil;
}

@end

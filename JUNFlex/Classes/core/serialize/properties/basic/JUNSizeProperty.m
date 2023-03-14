//
//  JTSizeProperties.m
//  JUNFlexTool
//
//  Created by Jun Ma on 2022/12/11.
//

#import "JUNSizeProperty.h"
#import <MJExtension/NSObject+MJKeyValue.h>

NSString * const JUNSizePropertyMax = @"max";
NSString * const JUNSizePropertyMin = @"min";

@implementation JUNSizeProperty

+ (NSMutableArray<NSString *> *)orderedKeys {
    return [NSMutableArray arrayWithArray:@[
        NSStringFromSelector(@selector(width)),
        NSStringFromSelector(@selector(height)),
    ]];
}

+ (NSArray *)mj_allowedPropertyNames {
    return @[];
}

- (void)mj_didConvertToObjectWithKeyValues:(NSDictionary *)keyValues {
    id width, height;
    if ((width = keyValues[NSStringFromSelector(@selector(width))])) {
        if ([width isEqual:JUNSizePropertyMax]) {
            self.width = @(CGFLOAT_MAX);
        } else if ([width isEqual:JUNSizePropertyMin]) {
            self.width = @(CGFLOAT_MIN);
        } else {
            NSParameterAssert([width isKindOfClass:[NSNumber class]]);
            self.width = width;
        }
    }
    if ((height = keyValues[NSStringFromSelector(@selector(height))])) {
        if ([height isEqual:JUNSizePropertyMax]) {
            self.height = @(CGFLOAT_MAX);
        } else if ([height isEqual:JUNSizePropertyMin]) {
            self.height = @(CGFLOAT_MIN);
        } else {
            NSParameterAssert([height isKindOfClass:[NSNumber class]]);
            self.height = height;
        }
    }
}

- (void)mj_objectDidConvertToKeyValues:(NSMutableDictionary *)keyValues {
    NSString *kWidth = NSStringFromSelector(@selector(width));
    if ([self.width isEqual:@(CGFLOAT_MAX)]) {
        keyValues[kWidth] = JUNSizePropertyMax;
    } else if ([self.width isEqual:@(CGFLOAT_MIN)]) {
        keyValues[kWidth] = JUNSizePropertyMin;
    } else {
        keyValues[kWidth] = self.width;
    }
    NSString *kHeight = NSStringFromSelector(@selector(height));
    if ([self.height isEqual:@(CGFLOAT_MAX)]) {
        keyValues[kHeight] = JUNSizePropertyMax;
    } else if ([self.height isEqual:@(CGFLOAT_MIN)]) {
        keyValues[kHeight] = JUNSizePropertyMin;
    } else {
        keyValues[kHeight] = self.height;
    }
}

@end

//
//  JUNAlignProperties.m
//  JUNFlexTool
//
//  Created by Jun Ma on 2022/12/10.
//

#import "JUNAlignProperty.h"
#import <MJExtension/NSObject+MJKeyValue.h>

@implementation JUNAlignProperty

NSString * const JUNAlignPropertyMax = @"max";
NSString * const JUNAlignPropertyCenter = @"center";
NSString * const JUNAlignPropertyMin = @"min";

+ (NSMutableArray<NSString *> *)orderedKeys {
    return [NSMutableArray arrayWithArray:@[
        NSStringFromSelector(@selector(main)),
        NSStringFromSelector(@selector(cross)),
    ]];
}

+ (NSArray *)mj_allowedPropertyNames {
    return @[];
}

- (void)mj_didConvertToObjectWithKeyValues:(NSDictionary *)keyValues {
    id main, cross;
    if ((main = keyValues[NSStringFromSelector(@selector(main))])) {
        if ([main isEqual:JUNAlignPropertyMax]) {
            self.main = @1;
        } else if ([main isEqual:JUNAlignPropertyCenter]) {
            self.main = @0;
        } else if ([main isEqual:JUNAlignPropertyMin]) {
            self.main = @(-1);
        } else {
            NSParameterAssert([main isKindOfClass:[NSNumber class]]);
            self.main = main;
        }
    }
    if ((cross = keyValues[NSStringFromSelector(@selector(cross))])) {
        if ([cross isEqual:JUNAlignPropertyMax]) {
            self.cross = @1;
        } else if ([main isEqual:JUNAlignPropertyCenter]) {
            self.cross = @0;
        } else if ([cross isEqual:JUNAlignPropertyMin]) {
            self.cross = @(-1);
        } else {
            NSParameterAssert([cross isKindOfClass:[NSNumber class]]);
            self.cross = cross;
        }
    }
}

- (void)mj_objectDidConvertToKeyValues:(NSMutableDictionary *)keyValues {
    NSString *kmain = NSStringFromSelector(@selector(main));
    if ([self.main isEqual:@1]) {
        keyValues[kmain] = JUNAlignPropertyMax;
    } else if ([self.main isEqual:@0]) {
        keyValues[kmain] = JUNAlignPropertyCenter;
    } else if ([self.main isEqual:@(-1)]) {
        keyValues[kmain] = JUNAlignPropertyMin;
    } else {
        keyValues[kmain] = self.main;
    }
    NSString *kcross = NSStringFromSelector(@selector(cross));
    if ([self.cross isEqual:@1]) {
        keyValues[kcross] = JUNAlignPropertyMax;
    } else if ([self.cross isEqual:@0]) {
        keyValues[kcross] = JUNAlignPropertyCenter;
    }  else if ([self.cross isEqual:@(-1)]) {
        keyValues[kcross] = JUNAlignPropertyMin;
    } else {
        keyValues[kcross] = self.cross;
    }
}

@end

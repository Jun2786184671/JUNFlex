//
//  JUNAlignProperties.m
//  JUNFlexTool
//
//  Created by Jun Ma on 2022/12/10.
//

#import "JUNAlignProperty.h"

@implementation JUNAlignProperty

+ (NSMutableArray<NSString *> *)orderedKeys {
    return [NSMutableArray arrayWithArray:@[
        NSStringFromSelector(@selector(main)),
        NSStringFromSelector(@selector(cross)),
    ]];
}

@end

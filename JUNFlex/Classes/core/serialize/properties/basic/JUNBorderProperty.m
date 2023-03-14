//
//  JTBorderProperty.m
//  JUNFlexTool
//
//  Created by Jun Ma on 2022/12/11.
//

#import "JUNBorderProperty.h"

@implementation JUNBorderProperty

+ (NSMutableArray<NSString *> *)orderedKeys {
    return [NSMutableArray arrayWithArray:@[
        NSStringFromSelector(@selector(width)),
        NSStringFromSelector(@selector(color)),
    ]];
}

@end

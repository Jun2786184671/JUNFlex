//
//  JUNTextProperties.m
//  JUNFlexTool
//
//  Created by Jun Ma on 2022/12/10.
//

#import "JUNTextProperty.h"

@implementation JUNTextProperty

+ (NSMutableArray<NSString *> *)orderedKeys {
    return [NSMutableArray arrayWithArray:@[
        NSStringFromSelector(@selector(string)),
        NSStringFromSelector(@selector(color)),
        NSStringFromSelector(@selector(textfont)),
    ]];
}

@end

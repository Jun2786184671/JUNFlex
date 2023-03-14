//
//  JUNActionProperty.m
//  JUNFlex
//
//  Created by Jun Ma on 2022/12/12.
//

#import "JUNActionProperty.h"
#import <MJExtension/NSObject+MJKeyValue.h>

@implementation JUNActionProperty

+ (NSMutableArray<NSString *> *)orderedKeys {
    return [NSMutableArray arrayWithArray:@[
        NSStringFromSelector(@selector(target)),
        NSStringFromSelector(@selector(selector)),
    ]];
}

+ (NSArray *)mj_ignoredPropertyNames {
    return @[
        NSStringFromSelector(@selector(target)),
    ];
}

@end

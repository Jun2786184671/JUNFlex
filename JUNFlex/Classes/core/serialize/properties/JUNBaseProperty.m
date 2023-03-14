//
//  JUNBaseProperties.m
//  JUNFlexTool
//
//  Created by Jun Ma on 2022/12/10.
//

#import "JUNBaseProperty.h"
#import <MJExtension/NSObject+MJKeyValue.h>

NSString * const kJUNBasePropertyJsonClassName = @"class";
NSString * const kJUNBasePropertyID = @"id";

@implementation JUNBaseProperty

+ (NSMutableArray *)orderedKeys {
    return [NSMutableArray arrayWithArray:@[
        kJUNBasePropertyID,
        kJUNBasePropertyJsonClassName,
        NSStringFromSelector(@selector(size)),
        NSStringFromSelector(@selector(radius)),
        NSStringFromSelector(@selector(color)),
        NSStringFromSelector(@selector(alpha)),
        NSStringFromSelector(@selector(border)),
        NSStringFromSelector(@selector(maskBounds)),
    ]];
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
        NSStringFromSelector(@selector(jsonClassName)) : kJUNBasePropertyJsonClassName,
        NSStringFromSelector(@selector(ID)) : kJUNBasePropertyID,
    };
}

@end

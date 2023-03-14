//
//  JUNBaseProperties.m
//  JUNFlexTool
//
//  Created by Jun Ma on 2022/12/10.
//

#import "JUNProperty.h"
#import <MJExtension/NSObject+MJKeyValue.h>
#import <OrderedDictionary/OrderedDictionary.h>

@implementation JUNProperty

+ (NSMutableArray<NSString *> *)orderedKeys {
    NSParameterAssert(false);
    return nil;
}

- (NSMutableDictionary *)mj_keyValues {
    NSDictionary *jsonObj = [super mj_keyValues];
    NSParameterAssert([jsonObj isKindOfClass:[NSDictionary class]]);
    MutableOrderedDictionary *orderedJson = [MutableOrderedDictionary dictionaryWithDictionary:jsonObj];
    NSArray<NSString *> *orderedKeys = [[self class] orderedKeys];
    [orderedKeys enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(NSString * _Nonnull key, NSUInteger idx, BOOL * _Nonnull stop) {
        if (![orderedJson objectForKey:key]) return;
        id obj = [orderedJson objectForKey:key];
        [orderedJson removeObjectForKey:key];
        [orderedJson insertObject:obj forKey:key atIndex:0];
    }];
    return [orderedJson copy];
}

@end

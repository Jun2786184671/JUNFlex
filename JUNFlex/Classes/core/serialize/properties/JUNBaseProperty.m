//
//  JUNBaseProperties.m
//  JUNFlexTool
//
//  Created by Jun Ma on 2022/12/10.
//

#import "JUNBaseProperty.h"
#import "JUNSerializer.h"
#import <MJExtension/NSObject+MJKeyValue.h>

NSString * const kJUNBasePropertyJsonClassName = @"class";
NSString * const kJUNBasePropertyID = @"id";

NSString * const JUNBasePropertyJsonClassSrc = @"src";

@interface JUNBaseProperty ()

@property(nonatomic, assign) BOOL converting;

@end

@implementation JUNBaseProperty

+ (NSMutableArray *)orderedKeys {
    return [NSMutableArray arrayWithArray:@[
        kJUNBasePropertyID,
        kJUNBasePropertyJsonClassName,
        NSStringFromSelector(@selector(path)),
        NSStringFromSelector(@selector(size)),
        NSStringFromSelector(@selector(radius)),
        NSStringFromSelector(@selector(color)),
        NSStringFromSelector(@selector(alpha)),
        NSStringFromSelector(@selector(border)),
        NSStringFromSelector(@selector(maskBounds)),
    ]];
}

+ (NSArray *)mj_ignoredPropertyNames {
    return @[
        NSStringFromSelector(@selector(converting)),
    ];
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
        NSStringFromSelector(@selector(jsonClassName)) : kJUNBasePropertyJsonClassName,
        NSStringFromSelector(@selector(ID)) : kJUNBasePropertyID,
    };
}

- (void)mj_didConvertToObjectWithKeyValues:(NSDictionary *)keyValues {
    if (self.converting || !self.path) return;
    self.converting = true;
    NSDictionary *json = [[JUNSerializer sharedSerializer] serializeJsonFile2Json:self.path];
    [self mj_setKeyValues:json];
    [self mj_setKeyValues:keyValues];
    self.jsonClassName = JUNBasePropertyJsonClassSrc;
    self.converting = false;
}

- (void)mj_objectDidConvertToKeyValues:(NSMutableDictionary *)keyValues {
    if (!self.path) return;
    NSDictionary *json = [[JUNSerializer sharedSerializer] serializeJsonFile2Json:self.path];
    [[keyValues copy] enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if (json[key] && [json[key] isEqual:obj]) {
            [keyValues removeObjectForKey:key];
        }
    }];
}

@end

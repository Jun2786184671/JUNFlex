//
//  JUNStackProperty.m
//  JUNFlex
//
//  Created by Jun Ma on 2023/3/7.
//

#import "JUNStackProperty.h"
#import "JUNSerializer.h"
#import "UIView+JUNFlex_Private.h"
#import <MJExtension/NSObject+MJKeyValue.h>

NSString * const kJUNStackPropertyChildren = @"children";

@implementation JUNStackProperty

+ (NSMutableArray<NSString *> *)orderedKeys {
    NSMutableArray *orderedKeys = [super orderedKeys];
    [orderedKeys addObjectsFromArray:@[
        NSStringFromSelector(@selector(align)),
        NSStringFromSelector(@selector(aspectRatio)),
        kJUNStackPropertyChildren,
    ]];
    return orderedKeys;
}

+ (NSArray *)mj_ignoredPropertyNames {
    return @[
        NSStringFromSelector(@selector(childrenViews)),
        NSStringFromSelector(@selector(childrenProperties)),
    ];
}

- (void)mj_didConvertToObjectWithKeyValues:(NSDictionary *)keyValues {
    NSArray<NSDictionary *> *childrenJsons = keyValues[kJUNStackPropertyChildren];
    if (![childrenJsons count]) return;
    NSParameterAssert([childrenJsons isKindOfClass:[NSArray<NSDictionary *> class]]);
    NSMutableArray<__kindof JUNBaseProperty *> *childrenProperties = [NSMutableArray arrayWithCapacity:[childrenJsons count]];
    NSMutableArray<__kindof UIView *> *childrenViews = [NSMutableArray arrayWithCapacity:[childrenJsons count]];
    JUNSerializer *serializer = [JUNSerializer sharedSerializer];
    for (NSDictionary *childJson in childrenJsons) {
        UIView *childView = [serializer serializeJson2View:childJson];
        [childrenViews addObject:childView];
        [childrenProperties addObject:childView.jun_property];
    }
    self.childrenViews = [childrenViews copy];
    self.childrenProperties = [childrenProperties copy];
}

- (void)mj_objectDidConvertToKeyValues:(NSMutableDictionary *)keyValues {
    if (!self.childrenProperties) {
        self.childrenProperties = [self.childrenViews valueForKey:NSStringFromSelector(@selector(jun_property))];
    }
    keyValues[kJUNStackPropertyChildren] = [self.childrenProperties valueForKey:NSStringFromSelector(@selector(mj_keyValues))];
}

@end

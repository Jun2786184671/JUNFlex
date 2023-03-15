//
//  JUNListProperty.m
//  JUNFlex
//
//  Created by Jun Ma on 2023/3/8.
//

#import "JUNListProperty.h"
#import "JUNSerializer.h"
#import "UIView+JUNFlex_Private.h"
#import <MJExtension/NSObject+MJKeyValue.h>

NSString * const kJUNListPropertyChildren = @"children";

@implementation JUNListProperty

+ (NSMutableArray<NSString *> *)orderedKeys {
    NSMutableArray *orderedKeys = [super orderedKeys];
    [orderedKeys addObjectsFromArray:@[
        NSStringFromSelector(@selector(itemSize)),
        NSStringFromSelector(@selector(itemSpacing)),
        NSStringFromSelector(@selector(lineSpacing)),
        NSStringFromSelector(@selector(horizontal)),
        NSStringFromSelector(@selector(alwaysBounce)),
        NSStringFromSelector(@selector(showIndicator)),
        kJUNListPropertyChildren,
    ]];
    return orderedKeys;
}

+ (NSArray *)mj_ignoredPropertyNames {
    return [[super mj_ignoredPropertyNames] arrayByAddingObjectsFromArray:@[
        NSStringFromSelector(@selector(childrenViews)),
        NSStringFromSelector(@selector(childrenProperties)),
    ]];
}

- (void)mj_didConvertToObjectWithKeyValues:(NSDictionary *)keyValues {
    [super mj_didConvertToObjectWithKeyValues:keyValues];
    NSArray<NSDictionary *> *childrenJsons = keyValues[kJUNListPropertyChildren];
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
    if ([self.childrenProperties count] || [self.childrenViews count]) {
        if (![self.childrenProperties count]) {
            self.childrenProperties = [self.childrenViews valueForKey:NSStringFromSelector(@selector(jun_property))];
        }
        keyValues[kJUNListPropertyChildren] = [self.childrenProperties valueForKey:NSStringFromSelector(@selector(mj_keyValues))];
    }
    [super mj_objectDidConvertToKeyValues:keyValues];
}

@end

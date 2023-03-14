//
//  JUNPaddingProperty.m
//  JUNFlex
//
//  Created by Jun Ma on 2023/3/8.
//

#import "JUNPaddingProperty.h"
#import "UIView+JUNFlex_Private.h"
#import "JUNSerializer.h"
#import <MJExtension/NSObject+MJKeyValue.h>

@implementation JUNPaddingProperty

static NSString * const kJUNPaddingPropertyAll = @"all";
static NSString * const kJUNPaddingPropertyChild = @"child";

+ (NSMutableArray *)orderedKeys {
    NSMutableArray *orderedKeys = [super orderedKeys];
    [orderedKeys addObjectsFromArray:@[
        NSStringFromSelector(@selector(top)),
        NSStringFromSelector(@selector(left)),
        NSStringFromSelector(@selector(bottom)),
        NSStringFromSelector(@selector(right)),
        kJUNPaddingPropertyAll,
        kJUNPaddingPropertyChild,
    ]];
    return orderedKeys;
}

+ (NSArray *)mj_ignoredPropertyNames {
    return @[
        NSStringFromSelector(@selector(childProperty)),
        NSStringFromSelector(@selector(childView)),
    ];
}

- (void)mj_didConvertToObjectWithKeyValues:(NSDictionary *)keyValues {
    NSDictionary *childDict = keyValues[kJUNPaddingPropertyChild];
    JUNSerializer *serializer = [JUNSerializer sharedSerializer];
    UIView *childView = [serializer serializeJson2View:childDict];
    self.childView = childView;
    self.childProperty = childView.jun_property;
    
    NSNumber *all = keyValues[kJUNPaddingPropertyAll];
    if (!all) return;
    self.top = all;
    self.left = all;
    self.bottom = all;
    self.right = all;
}

- (void)mj_objectDidConvertToKeyValues:(NSMutableDictionary *)keyValues {
    CGFloat top = [self.top floatValue];
    CGFloat left = [self.left floatValue];
    CGFloat bottom = [self.bottom floatValue];
    CGFloat right = [self.right floatValue];
    CGFloat all = top;
    if (all && all == left && all == bottom && all == right) {
        [keyValues removeObjectsForKeys:@[
            NSStringFromSelector(@selector(top)),
            NSStringFromSelector(@selector(left)),
            NSStringFromSelector(@selector(bottom)),
            NSStringFromSelector(@selector(right)),
        ]];
        keyValues[kJUNPaddingPropertyAll] = @(all);
    }
    if (!self.childProperty) {
        self.childProperty = self.childView.jun_property;
    }
    keyValues[kJUNPaddingPropertyChild] = [self.childProperty mj_keyValues];
}

@end

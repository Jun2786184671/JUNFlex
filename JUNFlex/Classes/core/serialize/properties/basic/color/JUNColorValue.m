//
//  JUNColorValue.m
//  JUNFlex
//
//  Created by Jun Ma on 2023/3/12.
//

#import "JUNColorValue.h"
#import <MJExtension/NSObject+MJKeyValue.h>

@implementation JUNColorValue

+ (NSMutableArray<NSString *> *)orderedKeys {
    return [NSMutableArray arrayWithArray:@[
        NSStringFromSelector(@selector(a)),
    ]];
}

- (void)mj_objectDidConvertToKeyValues:(NSMutableDictionary *)keyValues {
    if (self.a == 1.0f) {
        [keyValues removeObjectForKey:NSStringFromSelector(@selector(a))];
    }
}

- (void)mj_didConvertToObjectWithKeyValues:(NSDictionary *)keyValues {
    if (!keyValues[NSStringFromSelector(@selector(a))]) {
        self.a = 1.0f;
    }
}

@end

//
//  JUNItemProperties.m
//  JUNFlexTool
//
//  Created by Jun Ma on 2022/12/10.
//

#import "JUNItemProperty.h"

@implementation JUNItemProperty

+ (NSMutableArray *)orderedKeys {
    NSMutableArray *orderedKeys = [super orderedKeys];
    [orderedKeys addObjectsFromArray:@[
        NSStringFromSelector(@selector(align)),
        NSStringFromSelector(@selector(text)),
        NSStringFromSelector(@selector(image)),
        NSStringFromSelector(@selector(action)),
    ]];
    return orderedKeys;
}

@end

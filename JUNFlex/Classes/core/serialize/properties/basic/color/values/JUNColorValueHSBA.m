//
//  JUNColorHSBAValue.m
//  JUNFlex
//
//  Created by Jun Ma on 2023/3/12.
//

#import "JUNColorValueHSBA.h"

@implementation JUNColorValueHSBA

+ (NSMutableArray *)orderedKeys {
    NSMutableArray *orderedKeys = [super orderedKeys];
    [orderedKeys addObjectsFromArray:@[
        NSStringFromSelector(@selector(h)),
        NSStringFromSelector(@selector(s)),
        NSStringFromSelector(@selector(b)),
    ]];
    return orderedKeys;
}

@end

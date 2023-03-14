//
//  JUNColorWAValue.m
//  JUNFlex
//
//  Created by Jun Ma on 2023/3/12.
//

#import "JUNColorValueWA.h"

@implementation JUNColorValueWA

+ (NSMutableArray *)orderedKeys {
    NSMutableArray *orderedKeys = [super orderedKeys];
    [orderedKeys addObjectsFromArray:@[
        NSStringFromSelector(@selector(w)),
    ]];
    return orderedKeys;
}

@end

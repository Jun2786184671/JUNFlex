//
//  JUNColorValue.m
//  JUNFlex
//
//  Created by Jun Ma on 2023/3/12.
//

#import "JUNColorValue.h"

@implementation JUNColorValue

+ (NSMutableArray<NSString *> *)orderedKeys {
    return [NSMutableArray arrayWithArray:@[
        NSStringFromSelector(@selector(a)),
    ]];
}

@end

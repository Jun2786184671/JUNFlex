//
//  JUNFlex.m
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/27.
//

#import "JUNFlex.h"
#import "JUNHStackBuilder.h"
#import "JUNVStackBuilder.h"
#import "JUNZStackBuilder.h"

@implementation JUNFlex

+ (JUNStackBuilder *)Hstack {
    return [[JUNHStackBuilder alloc] init];
}

+ (JUNStackBuilder *)Vstack {
    return [[JUNVStackBuilder alloc] init];
}

+ (JUNStackBuilder *)Zstack {
    return [[JUNZStackBuilder alloc] init];
}

+ (JUNListBuilder *)List {
    return [[JUNListBuilder alloc] init];
}

+ (JUNPaddingBuilder *)Padding {
    return [[JUNPaddingBuilder alloc] init];
}

+ (JUNItemBuilder *)Item {
    return [[JUNItemBuilder alloc] init];
}

@end

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

+ (JUNStackBuilder *)hstack {
    return [[JUNHStackBuilder alloc] init];
}

+ (JUNStackBuilder *)vstack {
    return [[JUNVStackBuilder alloc] init];
}

+ (JUNStackBuilder *)zstack {
    return [[JUNZStackBuilder alloc] init];
}

+ (JUNListBuilder *)list {
    return [[JUNListBuilder alloc] init];
}

+ (JUNPaddingBuilder *)padding {
    return [[JUNPaddingBuilder alloc] init];
}

+ (JUNItemBuilder *)item {
    return [[JUNItemBuilder alloc] init];
}

+ (JUNPropertyBuilder * _Nonnull (^)(__kindof UIView * _Nonnull))config {
    return ^(__kindof UIView *target) {
        return [[JUNPropertyBuilder alloc] initWithTarget:target];
    };
}

@end

//
//  JUNZStackBuilder.m
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/28.
//

#import "JUNZStackBuilder.h"
#import "JUNBaseBuilder+Private.h"
#import "JUNZStack.h"

@interface JUNZStackBuilder ()

@property(nonatomic, strong) JUNZStack *zstack;

@end

@implementation JUNZStackBuilder

- (__kindof UIView *)product {
    return self.zstack;
}

- (JUNZStack *)zstack {
    if (!_zstack) {
        _zstack = [[JUNZStack alloc] init];
    }
    return _zstack;
}

@end

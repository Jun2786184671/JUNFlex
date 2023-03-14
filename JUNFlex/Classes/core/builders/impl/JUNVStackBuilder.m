//
//  JUNVStackBuilder.m
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/27.
//

#import "JUNVStackBuilder.h"
#import "JUNBaseBuilder+Private.h"
#import "JUNVStack.h"

@interface JUNVStackBuilder ()

@property(nonatomic, strong) JUNVStack *vstack;

@end

@implementation JUNVStackBuilder

- (__kindof UIView *)product {
    return self.vstack;
}

- (JUNVStack *)vstack {
    if (!_vstack) {
        _vstack = [[JUNVStack alloc] init];
    }
    return _vstack;
}

@end

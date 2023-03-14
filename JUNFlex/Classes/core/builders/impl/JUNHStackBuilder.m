//
//  JUNHStackBuilder.m
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/27.
//

#import "JUNHStackBuilder.h"
#import "JUNBaseBuilder+Private.h"
#import "JUNHStack.h"

@interface JUNHStackBuilder ()

@property(nonatomic, strong) JUNHStack *hstack;

@end

@implementation JUNHStackBuilder

- (__kindof UIView *)product {
    return self.hstack;
}

- (JUNHStack *)hstack {
    if (!_hstack) {
        _hstack = [[JUNHStack alloc] init];
    }
    return _hstack;
}

@end

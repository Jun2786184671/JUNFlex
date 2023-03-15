//
//  JUNNativeBuilder.m
//  JUNFlex
//
//  Created by Jun Ma on 2022/12/12.
//

#import "JUNPropertyBuilder.h"
#import "JUNBaseBuilder+Private.h"
#import "UIView+JUNFlex_Private.h"

@interface JUNPropertyBuilder ()

@property(nonatomic, strong) __kindof UIView *target;

@end

@implementation JUNPropertyBuilder

- (instancetype)initWithTarget:(id)target {
    if (self = [super init]) {
        NSAssert([target isKindOfClass:[UIView class]], @"build target must be a UIView");
        self.target = target;
    }
    return self;
}

- (id)product {
    return self.target;
}

- (__kindof JUNBaseProperty *)property {
    return [self.target jun_property];
}

@end

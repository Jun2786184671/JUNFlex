//
//  JUNPaddingBuilder.m
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/29.
//

#import "JUNPaddingBuilder.h"
#import "JUNBaseBuilder+Private.h"
#import "JUNPadding.h"
#import "JUNPaddingProperty.h"
#import "JUNPropertyParser.h"

@interface JUNPaddingBuilder ()

@property(nonatomic, strong) JUNPadding *padding;
@property(nonatomic, strong) JUNPaddingProperty *paddingProperty;

@end

@implementation JUNPaddingBuilder

- (id)product {
    return self.padding;
}

- (__kindof JUNBaseProperty *)property {
    return self.paddingProperty;
}

- (JUNPadding *)padding {
    if (!_padding) {
        _padding = [[JUNPadding alloc] init];
    }
    return _padding;
}

- (JUNPaddingProperty *)paddingProperty {
    if (!_paddingProperty) {
        _paddingProperty = [[JUNPaddingProperty alloc] init];
    }
    return _paddingProperty;
}

- (JUNPaddingBuilder * _Nonnull (^)(id))top {
    return ^(id value) {
        self.paddingProperty.top = [[JUNPropertyParser sharedParser] parseFloatWithValue:value];
        return self;
    };
}

- (JUNPaddingBuilder * _Nonnull (^)(id))left {
    return ^(id value) {
        self.paddingProperty.left = [[JUNPropertyParser sharedParser] parseFloatWithValue:value];
        return self;
    };
}

- (JUNPaddingBuilder * _Nonnull (^)(id))bottom {
    return ^(id value) {
        self.paddingProperty.bottom = [[JUNPropertyParser sharedParser] parseFloatWithValue:value];
        return self;
    };
}

- (JUNPaddingBuilder * _Nonnull (^)(id))right {
    return ^(id value) {
        self.paddingProperty.right = [[JUNPropertyParser sharedParser] parseFloatWithValue:value];
        return self;
    };
}

- (JUNPaddingBuilder * _Nonnull (^)(id))all {
    return ^(id value) {
        id all = [[JUNPropertyParser sharedParser] parseFloatWithValue:value];
        self.paddingProperty.top = all;
        self.paddingProperty.left = all;
        self.paddingProperty.bottom = all;
        self.paddingProperty.right = all;
        return self;
    };
}

- (JUNPaddingBuilder * _Nonnull (^)(id, ...))make {
    return ^(id arg, ...) {
        va_list args;
        va_start(args, arg);
        self.paddingProperty.top = arg;
        if (!(arg = va_arg(args, id))) goto END;
        self.paddingProperty.left = arg;
        if (!(arg = va_arg(args, id))) goto END;
        self.paddingProperty.bottom = arg;
        if (!(arg = va_arg(args, id))) goto END;
        self.paddingProperty.right = arg;
    END:
        va_end(args);
        return self;
    };
}

- (__kindof UIView * _Nonnull (^)(id _Nonnull))child {
    return ^(id child) {
        UIView *childView = [self _validateChild:child];
        childView.translatesAutoresizingMaskIntoConstraints = false;
        self.paddingProperty.childView = childView;
        return self.EOB;
    };
}

- (UIView *)_validateChild:(id)child {
    if ([child isKindOfClass:[UIView class]]) {
        return child;
    } else if ([child isKindOfClass:[JUNBaseBuilder class]]) {
        JUNBaseBuilder *childBuilder = (JUNBaseBuilder *)child;
        return childBuilder.EOB;
    }
    NSAssert(false, @"child of padding must be a uiview or itembuilder");
    return [[UIView alloc] init];
}

@end

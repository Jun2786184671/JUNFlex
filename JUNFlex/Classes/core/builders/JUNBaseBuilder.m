//
//  JUNAbstractBuilder.m
//  JUNFlex
//
//  Created by Jun Ma on 2022/12/1.
//

#import "JUNBaseBuilder.h"
#import "JUNBaseBuilder+Private.h"
#import "JUNBaseView.h"
#import "JUNBaseProperty.h"
#import "UIView+JUNFlex_Private.h"
#import "UIColor+JUNFlex_Private.h"
#import "JUNPropertyParser.h"

@implementation JUNBaseBuilder {
    @private
    UIView * _product;
    JUNBaseProperty *_property;
}

- (__kindof UIView *)product {
    if (!_product) {
        _product = [[JUNBaseView alloc] init];
    }
    return _product;
}

- (__kindof JUNBaseProperty *)property {
    if (!_property) {
        _property = [[JUNBaseProperty alloc] init];
    }
    return _property;
}

- (id _Nonnull (^)(id _Nonnull))ID {
    return ^(NSString *identifier) {
        self.property.ID = identifier;
        return self;
    };
}

- (id  _Nonnull (^)(id _Nonnull))data {
    return ^(id data) {
        self.property.data = data;
        return self;
    };
}

- (id _Nonnull (^)(id))color {
    return ^(id color) {
        self.property.color = [[JUNPropertyParser sharedParser] parseColorPropertyWithValue:color];
        return self;
    };
}

- (id _Nonnull (^)(id))alpha {
    return ^(id value) {
        self.property.alpha = [[JUNPropertyParser sharedParser] parseFloatWithValue:value];
        return self;
    };
}

- (id _Nonnull (^)(id))radius {
    return ^(id value) {
        self.property.radius = [[JUNPropertyParser sharedParser] parseFloatWithValue:value];
        return self;
    };
}

- (id  _Nonnull (^)(id _Nonnull, ...))border {
    return ^(id arg, ...) {
        JUNBorderProperty *border = [[JUNBorderProperty alloc] init];
        JUNPropertyParser *parser = [JUNPropertyParser sharedParser];
        va_list args;
        va_start(args, arg);
        do {
            if ([arg isKindOfClass:[NSNumber class]]) {
                border.width = arg;
            } else if ([arg isKindOfClass:[UIColor class]]) {
                border.color = [parser parseColorPropertyWithValue:arg];
            } else if ([arg isKindOfClass:[NSString class]]) {
                if ([parser isStringColorHexString:arg]) {
                    border.color = [parser parseColorPropertyWithValue:arg];
                } else if ([arg floatValue]) {
                    border.width = [parser parseFloatWithValue:arg];
                }
            }
        } while ((arg = va_arg(args, id)));
        va_end(args);
        self.property.border = border;
        return self;
    };
}

- (id _Nonnull (^)(id))maskBounds {
    return ^(id value) {
        self.property.maskBounds = [[JUNPropertyParser sharedParser] parseBoolWithValue:value];
        return self;
    };
}

- (id _Nonnull (^)(id))width {
    return ^(id value) {
        if (!self.property.size) {
            self.property.size = [[JUNSizeProperty alloc] init];
        }
        self.property.size.width = [[JUNPropertyParser sharedParser] parseFloatWithValue:value];
        return self;
    };
}

- (id _Nonnull (^)(id))height {
    return ^(id value) {
        if (!self.property.size) {
            self.property.size = [[JUNSizeProperty alloc] init];
        }
        self.property.size.height = [[JUNPropertyParser sharedParser] parseFloatWithValue:value];
        return self;
    };
}

- (id  _Nonnull (^)(id, ...))size {
    return ^(id arg, ...) {
        va_list args;
        va_start(args, arg);
        self.width(arg);
        self.height(va_arg(args, id) ?: arg);
        va_end(args);
        return self;
    };
}

- (id)EOB {
    if (!self.property.jsonClassName) {
        self.property.jsonClassName = [[self.product class] jun_getJsonClassName];
    }
    [self.product jun_setProperty:self.property];
    return self.product;
}

@end

//
//  JUNItemBuilder.m
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/29.
//

#import "JUNBaseBuilder+Private.h"
#import "JUNItemBuilder.h"
#import "JUNItemProperty.h"
#import "JUNItem.h"
#import "JUNPropertyParser.h"

@interface JUNItemBuilder ()

@property(nonatomic, strong) JUNItem *item;
@property(nonatomic, strong) JUNItemProperty *itemProperty;

@end

@implementation JUNItemBuilder

- (__kindof UIView *)product {
    return self.item;
}

- (__kindof JUNBaseProperty *)property {
    return self.itemProperty;
}

- (JUNItem *)item {
    if (!_item) {
        _item = [[JUNItem alloc] init];
    }
    return _item;
}

- (JUNItemProperty *)itemProperty {
    if (!_itemProperty) {
        _itemProperty = [[JUNItemProperty alloc] init];
    }
    return _itemProperty;
}

- (JUNItemBuilder * _Nonnull (^)(id, id))align {
    return ^(id main, id cross) {
        JUNAlignProperty *align = [[JUNAlignProperty alloc] init];
        align.main = main;
        align.cross = cross;
        self.itemProperty.align = align;
        return self;
    };
}

- (JUNItemBuilder * _Nonnull (^)(NSString * _Nonnull, ...))text {
    return ^(NSString *string, ...) {
        JUNTextProperty *text = [[JUNTextProperty alloc] init];
        text.string = string;
        va_list args;
        id arg;
        va_start(args, string);
        int i = 0;
        JUNPropertyParser *parser = [JUNPropertyParser sharedParser];
        while (i < 2 && (arg = va_arg(args, id))) {
            if ([arg isKindOfClass:[UIFont class]] || [arg isKindOfClass:[NSNumber class]]) {
                text.font = [parser parseFontPropertyWithValue:arg];
            } else if ([arg isKindOfClass:[UIColor class]]) {
                text.color = [parser parseColorPropertyWithValue:arg];
            } else if ([arg isKindOfClass:[NSString class]]) {
                if ([parser isStringColorHexString:arg]) {
                    text.color = [parser parseColorPropertyWithValue:arg];
                } else if ([arg floatValue]) {
                    text.font = [parser parseFontPropertyWithValue:arg];
                }
            }
            i++;
        }
        va_end(args);
        self.itemProperty.text = text;
        return self;
    };
}

- (JUNItemBuilder * _Nonnull (^)(NSString * _Nonnull))image {
    return ^(NSString *nameOrURL) {
        self.itemProperty.image = nameOrURL;
        return self;
    };
}

- (JUNItemBuilder * _Nonnull (^)(id _Nonnull, SEL _Nonnull))action {
    return ^(id target, SEL selector) {
        JUNActionProperty *action = [[JUNActionProperty alloc] init];
        action.target = target;
        action.selector = NSStringFromSelector(selector);
        self.itemProperty.action = action;
        return self;
    };
}

@end

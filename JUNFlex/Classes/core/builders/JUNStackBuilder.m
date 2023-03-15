//
//  JUNStackBuilder.m
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/27.
//

#import "JUNStackBuilder.h"
#import "JUNBaseBuilder+Private.h"
#import "JUNStack.h"
#import "JUNPropertyParser.h"
#import "JUNSerializer.h"

@interface JUNStackBuilder ()

@property(nonatomic, strong) JUNStackProperty *stackProperty;

@end

@implementation JUNStackBuilder

- (__kindof JUNBaseProperty *)property {
    return self.stackProperty;
}

- (JUNStackProperty *)stackProperty {
    if (!_stackProperty) {
        _stackProperty = [[JUNStackProperty alloc] init];
    }
    return _stackProperty;
}

- (JUNStackBuilder * _Nonnull (^)(id, ...))align {
    return ^(id arg, ...) {
        JUNAlignProperty *align = [[JUNAlignProperty alloc] init];
        JUNPropertyParser *parser = [JUNPropertyParser sharedParser];
        va_list args;
        va_start(args, arg);
        align.cross = [parser parseAlignWithValue:arg];
        if ((arg = va_arg(args, id))) {
            align.main = align.cross;
            align.cross = [parser parseAlignWithValue:arg];
        }
        va_end(args);
        self.stackProperty.align = align;
        return self;
    };
}

- (JUNStackBuilder * _Nonnull (^)(id))aspectRatio {
    return ^(id value) {
        self.stackProperty.aspectRatio = [[JUNPropertyParser sharedParser] parseBoolWithValue:value];
        return self;
    };
}

- (__kindof UIView * _Nonnull (^)(NSArray<id> * _Nonnull))children {
    return ^(NSArray<UIView *> *children) {
        if (children.count == 0) {
            NSAssert(false, @"stack must contain at least one child");
            return self.EOB;
        }
        
        NSArray<__kindof UIView *> *childrenViews = [self _validateChildren:children];
        self.stackProperty.childrenViews = childrenViews;
        return self.EOB;
    };
}

- (NSArray<UIView *> *)_validateChildren:(NSArray<id> *)children {
    NSMutableArray *childrenViews = [NSMutableArray arrayWithArray:children];
    for (int i = 0; i < children.count; i++) {
        id child = children[i];
        if ([child isKindOfClass:[JUNBaseBuilder class]]) {
            JUNBaseBuilder *builder = (JUNBaseBuilder *)child;
            [childrenViews replaceObjectAtIndex:i withObject:builder.EOB];
        } else if (![child isKindOfClass:[UIView class]]) {
            NSAssert(false, @"children must be uiviews or builders");
        }
    }
    return [childrenViews copy];
}

@end

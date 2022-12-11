//
//  JUNStackBuilder.m
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/27.
//

#import "JUNStackBuilder.h"
#import "JUNStackBuilder+Private.h"
#import "JUNAbstractBuilder+Private.h"
#import "JUNStackContainer.h"
#import "JUNStack.h"
#import "JUNJSONSerializer.h"

@interface JUNStackBuilder ()

@property(nonatomic, strong) JUNItem *stack;

@property(nonatomic, assign) int mainAxisAlignment;
@property(nonatomic, assign) int crossAxisAlignment;
@property(nonatomic, assign, getter=is_aspect_ratio) bool aspect_ratio;

@end

@implementation JUNStackBuilder

+ (void)load {
    [super load];
}

- (id)product {
    return self.stack;
}

- (JUNItem *)stack {
    if (_stack == nil) {
        _stack = [[JUNStackContainer alloc] init];
    }
    return _stack;
}

- (JUNStackBuilder * _Nonnull (^)(int, int))align {
    return ^(int mainAxisAlignment, int crossAxisAlignment) {
        self.mainAxisAlignment = mainAxisAlignment;
        self.crossAxisAlignment = crossAxisAlignment;
        return self;
    };
}

- (JUNStackBuilder * _Nonnull (^)(bool))aspectRatio {
    return ^(bool aspectRatio) {
        self.aspect_ratio = aspectRatio;
        return self;
    };
}

// build method
- (JUNItem * _Nonnull (^)(NSArray<id> * _Nonnull))children {
    return ^(NSArray<UIView *> *children) {
        if (children.count == 0) {
            NSAssert(false, @"stack must contain at least onw child");
            return self.EOB;
        }
        
        NSArray<UIView *> *validChildren = [self _validateChildren:children];
        JUNStack *stack = [self _getProductWithChildren:validChildren mainAxisAlignment:self.mainAxisAlignment crossAxisAlignment:self.crossAxisAlignment aspectRatio:self.is_aspect_ratio];
        
        stack.translatesAutoresizingMaskIntoConstraints = false;
        [self.stack addSubview:stack];
        [self.stack addConstraints:@[
            [NSLayoutConstraint constraintWithItem:stack attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.stack attribute:NSLayoutAttributeTop multiplier:1.0f constant:0.0f],
            [NSLayoutConstraint constraintWithItem:stack attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.stack attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0.0f],
            [NSLayoutConstraint constraintWithItem:stack attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.stack attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0.0f],
            [NSLayoutConstraint constraintWithItem:stack attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.stack attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0.0f],
        ]];
        return self.EOB;
    };
}

- (UIView *)buildWithDictionary:(NSDictionary *)dict {
    [super buildWithDictionary:dict];
    [self _configAspectRatioWithDictionary:dict];
    [self _configAlignmentWithDictionary:dict];
    [self _configChildrenWithDictionary:dict];
    return self.EOB;
}

- (NSArray<UIView *> *)_validateChildren:(NSArray<id> *)children {
    NSMutableArray *validChildren = [NSMutableArray arrayWithArray:children];
    for (int i = 0; i < children.count; i++) {
        id child = children[i];
        if ([child isKindOfClass:[JUNItemBuilder class]]) {
            JUNItemBuilder *builder = (JUNItemBuilder *)child;
            [validChildren replaceObjectAtIndex:i withObject:builder.EOB];
        }
    }
    return [validChildren copy];
}

- (void)_configAspectRatioWithDictionary:(NSDictionary *)dict {
    id aspectRatio = dict[@"aspect_ratio"];
    self.aspectRatio([self _boolFromValue:aspectRatio]);
}

- (void)_configAlignmentWithDictionary:(NSDictionary *)dict {
    id alignment = dict[@"align"];
    if (alignment == nil) return;
    NSAssert([alignment isKindOfClass:[NSDictionary class]], @"unexpected alignment format");
    id mainAlign = [alignment valueForKey:@"main"];
    int mainAlignRaw = 0;
    if ([mainAlign isKindOfClass:[NSString class]]) {
        if ([mainAlign isEqualToString:@"min"]) {
            mainAlignRaw = -1;
        } else if ([mainAlign isEqualToString:@"center"]) {
            mainAlignRaw = 0;
        } else if ([mainAlign isEqualToString:@"max"]) {
            mainAlignRaw = 1;
        } else {
            mainAlignRaw = [self _intFromValue:mainAlign];
        }
    } else {
        mainAlignRaw = [self _intFromValue:mainAlign];
    }
    id crossAlign = [alignment valueForKey:@"cross"];
    int crossAlignRaw = 0;
    if ([crossAlign isKindOfClass:[NSString class]]) {
        if ([crossAlign isEqualToString:@"min"]) {
            crossAlignRaw = -1;
        } else if ([crossAlign isEqualToString:@"center"]) {
            crossAlignRaw = 0;
        } else if ([crossAlign isEqualToString:@"max"]) {
            crossAlignRaw = 1;
        } else {
            crossAlignRaw = [self _intFromValue:crossAlign];
        }
    } else {
        crossAlignRaw = [self _intFromValue:crossAlign];
    }
    self.align(mainAlignRaw, crossAlignRaw);
}

- (void)_configChildrenWithDictionary:(NSDictionary *)dict {
    id childrenDicts = dict[@"children"];
    NSAssert(childrenDicts, @"stack must have children");
    NSAssert([childrenDicts isKindOfClass:[NSArray class]], @"unexpected children format");
    NSMutableArray *childrenViews = [NSMutableArray arrayWithCapacity:[childrenDicts count]];
    for (NSDictionary *dict in childrenDicts) {
        UIView *view = [[JUNJSONSerializer sharedInstance] serialize:dict];
        [childrenViews addObject:view];
    }
    self.children(childrenViews);
}

- (JUNStack *)_getProductWithChildren:(NSArray<id> *)children mainAxisAlignment:(int)mainAxisAlignment crossAxisAlignment:(int)crossAxisAlignment aspectRatio:(bool)aspectRatio {
    return nil;
}

@end

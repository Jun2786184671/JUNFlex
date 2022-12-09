//
//  $StackBuilder.m
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/27.
//

#import "$StackBuilder.h"
#import "$StackBuilder+Private.h"
#import "$AbstractBuilder+Private.h"
#import "$Stack.h"
#import "$JSONSerializer.h"

@interface $StackBuilder ()

@property(nonatomic, strong) $Item *$product;

@property(nonatomic, assign) int mainAxisAlignment;
@property(nonatomic, assign) int crossAxisAlignment;

@end

@implementation $StackBuilder

+ (void)load {
    [super load];
}

- (id)product {
    return self.$product;
}

- ($Item *)$product {
    if (_$product == nil) {
        _$product = [[$Item alloc] init];
    }
    return _$product;
}

- ($StackBuilder * _Nonnull (^)(int, int))align {
    return ^(int mainAxisAlignment, int crossAxisAlignment) {
        self.mainAxisAlignment = mainAxisAlignment;
        self.crossAxisAlignment = crossAxisAlignment;
        return self;
    };
}

// build method
- (UIView * _Nonnull (^)(NSArray<id> * _Nonnull))children {
    return ^(NSArray<UIView *> *children) {
        if (children.count == 0) {
            NSAssert(false, @"stack must contain at least onw child");
            return self.EOB;
        }
        
        NSArray<UIView *> *$children = [self _validateChildren:children];
        $Stack *stack = [self _getProductWithChildren:$children mainAxisAlignment:self.mainAxisAlignment crossAxisAlignment:self.crossAxisAlignment];
        
        stack.translatesAutoresizingMaskIntoConstraints = false;
        [self.$product addSubview:stack];
        [self.$product addConstraints:@[
            [NSLayoutConstraint constraintWithItem:stack attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.$product attribute:NSLayoutAttributeTop multiplier:1.0f constant:0.0f],
            [NSLayoutConstraint constraintWithItem:stack attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.$product attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0.0f],
            [NSLayoutConstraint constraintWithItem:stack attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.$product attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0.0f],
            [NSLayoutConstraint constraintWithItem:stack attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.$product attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0.0f],
        ]];
        return self.EOB;
    };
}

- (UIView *)buildWithDictionary:(NSDictionary *)dict {
    [super buildWithDictionary:dict];
    [self _configAlignmentWithDictionary:dict];
    [self _configChildrenWithDictionary:dict];
    return self.EOB;
}

- (NSArray<UIView *> *)_validateChildren:(NSArray<id> *)children {
    NSMutableArray *$children = [NSMutableArray arrayWithArray:children];
    for (int i = 0; i < children.count; i++) {
        id child = children[i];
        if ([child isKindOfClass:[$ItemBuilder class]]) {
            $ItemBuilder *builder = ($ItemBuilder *)child;
            [$children replaceObjectAtIndex:i withObject:builder.EOB];
        }
    }
    return [$children copy];
}

- (void)_configAlignmentWithDictionary:(NSDictionary *)dict {
    id alignment = dict[@"alignment"];
    if (alignment == nil) return;
    NSAssert([alignment isKindOfClass:[NSDictionary class]], @"unexpected alignment format");
    id mainAlign = [alignment valueForKey:@"mainAxis"];
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
    id crossAlign = [alignment valueForKey:@"crossAxis"];
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
        UIView *view = [[$JSONSerializer sharedInstance] serialize:dict];
        [childrenViews addObject:view];
    }
    self.children(childrenViews);
}

- ($Stack *)_getProductWithChildren:(NSArray<id> *)children mainAxisAlignment:(int)mainAxisAlignment crossAxisAlignment:(int)crossAxisAlignment {
    return nil;
}

@end

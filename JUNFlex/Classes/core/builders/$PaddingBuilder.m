//
//  $PaddingBuilder.m
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/29.
//

#import "$PaddingBuilder.h"
#import "$AbstractBuilder+Private.h"
#import "$Item.h"
#import "$JSONSerializer.h"
#import "UIView+JUNex4Flex.h"

@interface $PaddingBuilder ()

@property(nonatomic, strong) $Item *$product;

@property(nonatomic, assign) UIEdgeInsets $paddings;

@end

@implementation $PaddingBuilder

+ (void)load {
    [super load];
}

+ (NSString *)type {
    return @"padding";
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

- ($PaddingBuilder * _Nonnull (^)(CGFloat))top {
    return ^(CGFloat top) {
        UIEdgeInsets paddings = self.$paddings;
        paddings.top = top;
        self.$paddings = paddings;
        return self;
    };
}

- ($PaddingBuilder * _Nonnull (^)(CGFloat))left {
    return ^(CGFloat left) {
        UIEdgeInsets paddings = self.$paddings;
        paddings.left = left;
        self.$paddings = paddings;
        return self;
    };
}

- ($PaddingBuilder * _Nonnull (^)(CGFloat))bottom {
    return ^(CGFloat bottom) {
        UIEdgeInsets paddings = self.$paddings;
        paddings.bottom = bottom;
        self.$paddings = paddings;
        return self;
    };
}

- ($PaddingBuilder * _Nonnull (^)(CGFloat))right {
    return ^(CGFloat right) {
        UIEdgeInsets paddings = self.$paddings;
        paddings.right = right;
        self.$paddings = paddings;
        return self;
    };
}

- ($PaddingBuilder * _Nonnull (^)(CGFloat))all {
    return ^(CGFloat all) {
        self.$paddings = UIEdgeInsetsMake(all, all, all, all);
        return self;
    };
}

- ($PaddingBuilder * _Nonnull (^)(CGFloat, CGFloat, CGFloat, CGFloat))make {
    return ^(CGFloat t, CGFloat l, CGFloat b, CGFloat r) {
        self.$paddings = UIEdgeInsetsMake(t, l, b, r);
        return self;
    };
}

- (UIView * _Nonnull (^)(id _Nonnull))child {
    return ^(id child) {
        UIView *$child = [self _validateChild:child];
        
        $child.translatesAutoresizingMaskIntoConstraints = false;
        [self.$product addSubview:$child];
        [self.$product addConstraints:@[
            [NSLayoutConstraint constraintWithItem:$child attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.$product attribute:NSLayoutAttributeTop multiplier:1.0f constant:self.$paddings.top],
            [NSLayoutConstraint constraintWithItem:$child attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.$product attribute:NSLayoutAttributeBottom multiplier:1.0f constant:-self.$paddings.bottom],
            [NSLayoutConstraint constraintWithItem:$child attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.$product attribute:NSLayoutAttributeLeading multiplier:1.0f constant:self.$paddings.left],
            [NSLayoutConstraint constraintWithItem:$child attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.$product attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:-self.$paddings.right],
        ]];
        return self.EOB;
    };
}

- (UIView *)buildWithDictionary:(NSDictionary *)dict {
    [super buildWithDictionary:dict];
    
    id top = dict[@"top"];
    if (top) {
        self.top([self _floatFromValue:top]);
    }
    id left = dict[@"left"];
    if (left) {
        self.left([self _floatFromValue:left]);
    }
    id bottom = dict[@"bottom"];
    if (bottom) {
        self.bottom([self _floatFromValue:bottom]);
    }
    id right = dict[@"right"];
    if (right) {
        self.right([self _floatFromValue:right]);
    }
    id all = dict[@"all"];
    if (all) {
        self.all([self _floatFromValue:all]);
    }
    
    id childDict = dict[@"child"];
    if (childDict) {
        NSAssert([childDict isKindOfClass:[NSDictionary class]], @"unexpected child format");
        UIView *childView = [[$JSONSerializer sharedInstance] serialize:childDict];
        self.child(childView);
    }
    return self.EOB;
}

- (UIView *)_validateChild:(id)child {
    if ([child isKindOfClass:[UIView class]]) {
        return child;
    } else if ([child isKindOfClass:[$AbstractBuilder class]]) {
        $AbstractBuilder *builder = ($AbstractBuilder *)child;
        return builder.EOB;
    }
    NSAssert(false, @"child of padding must be a uiview or itembuilder");
    return [[UIView alloc] init];
}

@end

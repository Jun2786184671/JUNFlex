//
//  JUNPaddingBuilder.m
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/29.
//

#import "JUNPaddingBuilder.h"
#import "JUNAbstractBuilder+Private.h"
#import "JUNItem.h"
#import "JUNJSONSerializer.h"
#import "UIView+JUNFlex_Private.h"

@interface JUNPaddingBuilder ()

@property(nonatomic, strong) JUNItem *padding;

@property(nonatomic, assign) UIEdgeInsets insets;

@end

@implementation JUNPaddingBuilder

+ (void)load {
    [super load];
}

+ (NSString *)type {
    return @"padding";
}

- (id)product {
    return self.padding;
}

- (JUNItem *)padding {
    if (_padding == nil) {
        _padding = [[JUNItem alloc] init];
    }
    return _padding;
}

- (JUNPaddingBuilder * _Nonnull (^)(CGFloat))top {
    return ^(CGFloat top) {
        UIEdgeInsets paddings = self.insets;
        paddings.top = top;
        self.insets = paddings;
        return self;
    };
}

- (JUNPaddingBuilder * _Nonnull (^)(CGFloat))left {
    return ^(CGFloat left) {
        UIEdgeInsets paddings = self.insets;
        paddings.left = left;
        self.insets = paddings;
        return self;
    };
}

- (JUNPaddingBuilder * _Nonnull (^)(CGFloat))bottom {
    return ^(CGFloat bottom) {
        UIEdgeInsets paddings = self.insets;
        paddings.bottom = bottom;
        self.insets = paddings;
        return self;
    };
}

- (JUNPaddingBuilder * _Nonnull (^)(CGFloat))right {
    return ^(CGFloat right) {
        UIEdgeInsets paddings = self.insets;
        paddings.right = right;
        self.insets = paddings;
        return self;
    };
}

- (JUNPaddingBuilder * _Nonnull (^)(CGFloat))all {
    return ^(CGFloat all) {
        self.insets = UIEdgeInsetsMake(all, all, all, all);
        return self;
    };
}

- (JUNPaddingBuilder * _Nonnull (^)(CGFloat, CGFloat, CGFloat, CGFloat))make {
    return ^(CGFloat t, CGFloat l, CGFloat b, CGFloat r) {
        self.insets = UIEdgeInsetsMake(t, l, b, r);
        return self;
    };
}

- (JUNItem * _Nonnull (^)(id _Nonnull))child {
    return ^(id child) {
        UIView *validChild = [self _validateChild:child];
        
        validChild.translatesAutoresizingMaskIntoConstraints = false;
        [self.padding addSubview:validChild];
        [self.padding addConstraints:@[
            [NSLayoutConstraint constraintWithItem:validChild attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.padding attribute:NSLayoutAttributeTop multiplier:1.0f constant:self.insets.top],
            [NSLayoutConstraint constraintWithItem:validChild attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.padding attribute:NSLayoutAttributeBottom multiplier:1.0f constant:-self.insets.bottom],
            [NSLayoutConstraint constraintWithItem:validChild attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.padding attribute:NSLayoutAttributeLeading multiplier:1.0f constant:self.insets.left],
            [NSLayoutConstraint constraintWithItem:validChild attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.padding attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:-self.insets.right],
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
        UIView *childView = [[JUNJSONSerializer sharedInstance] serialize:childDict];
        self.child(childView);
    }
    return self.EOB;
}

- (UIView *)_validateChild:(id)child {
    if ([child isKindOfClass:[UIView class]]) {
        return child;
    } else if ([child isKindOfClass:[JUNAbstractBuilder class]]) {
        JUNAbstractBuilder *builder = (JUNAbstractBuilder *)child;
        return builder.EOB;
    }
    NSAssert(false, @"child of padding must be a uiview or itembuilder");
    return [[UIView alloc] init];
}

@end

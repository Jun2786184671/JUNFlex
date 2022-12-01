//
//  JUNInsetWrapper.m
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/29.
//

#import "$PaddingBuilder.h"
#import "JUNItemBuilder+Private.h"
#import "UIView+JUNex4Flex.h"

@interface $PaddingBuilder ()

@property(nonatomic, copy) NSString *$ID;
@property(nonatomic, strong) UIColor *$color;
@property(nonatomic, assign) CGFloat $alpha;
@property(nonatomic, assign) CGFloat $radius;
@property(nonatomic, assign) bool $maskBounds;
@property(nonatomic, assign) CGFloat $width;
@property(nonatomic, assign) CGFloat $height;
@property(nonatomic, assign) UIEdgeInsets $paddings;

@end

@implementation $PaddingBuilder

- (instancetype)init {
    if (self = [super init]) {
        self.$paddings = UIEdgeInsetsZero;
    }
    return self;
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
    return ^(id content) {
        UIView *validContent = [self _validateTarget:content];
        
        validContent.translatesAutoresizingMaskIntoConstraints = false;
        [self.target addSubview:validContent];
        [self.target addConstraints:@[
            [NSLayoutConstraint constraintWithItem:validContent attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.target attribute:NSLayoutAttributeTop multiplier:1.0f constant:self.$paddings.top],
            [NSLayoutConstraint constraintWithItem:validContent attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.target attribute:NSLayoutAttributeBottom multiplier:1.0f constant:-self.$paddings.bottom],
            [NSLayoutConstraint constraintWithItem:validContent attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.target attribute:NSLayoutAttributeLeading multiplier:1.0f constant:self.$paddings.left],
            [NSLayoutConstraint constraintWithItem:validContent attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.target attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:-self.$paddings.right],
        ]];
        return self.end;
    };
}

- (UIView *)_validateTarget:(id)target {
    if ([target isKindOfClass:[UIView class]]) {
        return target;
    } else if ([target isKindOfClass:[$ItemBuilder class]]) {
        $ItemBuilder *builder = ($ItemBuilder *)target;
        return builder.end;
    }
    NSAssert(false, @"child of padding must be a uiview or itembuilder");
    return [[UIView alloc] init];
}

@end

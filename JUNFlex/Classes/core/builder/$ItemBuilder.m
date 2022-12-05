//
//  $ItemBuilder.m
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/29.
//

#import <SDWebImage/SDWebImage.h>
#import "$AbstractBuilder+Private.h"
#import "$ItemBuilder.h"
#import "$Item.h"

@interface $ItemBuilder ()

@property(nonatomic, strong) $Item *$product;

@end

@implementation $ItemBuilder

- (id)product {
    return self.$product;
}

- ($Item *)$product {
    if (_$product == nil) {
        _$product = [[$Item alloc] init];
    }
    return _$product;
}

- ($ItemBuilder * _Nonnull (^)(NSString * _Nonnull, CGFloat, UIColor * _Nonnull))text {
    return ^(NSString *text, CGFloat fontSize, UIColor *color) {
        [self.$product setTitle:text forState:UIControlStateNormal];
        [self.$product setTitleColor:color forState:UIControlStateNormal];
        self.$product.titleLabel.font = [UIFont systemFontOfSize:fontSize];
        return self;
    };
}

- ($ItemBuilder * _Nonnull (^)(UIControlContentHorizontalAlignment, UIControlContentVerticalAlignment))contentAlign {
    return ^(UIControlContentHorizontalAlignment h, UIControlContentVerticalAlignment v) {
        [self.$product setContentHorizontalAlignment:h];
        [self.$product setContentVerticalAlignment:v];
        return self;
    };
}

- ($ItemBuilder * _Nonnull (^)(NSString * _Nonnull))image {
    return ^(NSString *nameOrURL) {
        NSURL *URL = [NSURL URLWithString:nameOrURL];
        bool isURL = URL.scheme.length && URL.host.length && URL.path.length;
        if (isURL) {
            [self.$product sd_setBackgroundImageWithURL:URL forState:UIControlStateNormal placeholderImage:nil];
        } else {
            UIImage *image = [UIImage imageNamed:nameOrURL];
            [self.$product setBackgroundImage:image forState:UIControlStateNormal];
        }
        return self;
    };
}

- ($ItemBuilder * _Nonnull (^)(id _Nonnull, SEL _Nonnull))onTap {
    return ^(id target, SEL selector) {
        [self.$product addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
        return self;
    };
}

@end

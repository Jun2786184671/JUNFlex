//
//  $ListBuilder.m
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/30.
//

#import "$AbstractBuilder+Private.h"
#import "$ListBuilder.h"
#import "$Item.h"
#import "UICollectionView+JUNex.h"

@interface $ListBuilder ()

@property(nonatomic, strong) $Item *$product;

@property(nonatomic, assign) bool $maskBounds;
@property(nonatomic, assign) CGSize $itemSize;
@property(nonatomic, assign) CGFloat $itemSpacing;
@property(nonatomic, assign) CGFloat $lineSpacing;
@property(nonatomic, assign) bool $isHorizontal;
@property(nonatomic, assign) bool $isAlwaysBounce;
@property(nonatomic, assign) bool $isShowIndicator;

@end

@implementation $ListBuilder

+ (void)load {
    [super load];
}

+ (NSString *)type {
    return @"list";
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

- ($ListBuilder * _Nonnull (^)(bool))horizontal {
    return ^(bool isHorizontal) {
        self.$isHorizontal = isHorizontal;
        return self;
    };
}

- ($ListBuilder * _Nonnull (^)(bool))alwaysBounce {
    return ^(bool isAlwaysBounce) {
        self.$isAlwaysBounce = isAlwaysBounce;
        return self;
    };
}

- ($ListBuilder * _Nonnull (^)(bool))showIndicator {
    return ^(bool isShowIndicator) {
        self.$isShowIndicator = isShowIndicator;
        return self;
    };
}

- ($ListBuilder * _Nonnull (^)(CGFloat, CGFloat))itemSize {
    return ^(CGFloat width, CGFloat height) {
        self.$itemSize = CGSizeMake(width, height);
        return self;
    };
}

- ($ListBuilder * _Nonnull (^)(CGFloat))itemSpacing {
    return ^(CGFloat itemSpacing) {
        self.$itemSpacing = itemSpacing;
        return self;
    };
}

- ($ListBuilder * _Nonnull (^)(CGFloat))lineSpacing {
    return ^(CGFloat lineSpacing) {
        self.$lineSpacing = lineSpacing;
        return self;
    };
}

- (UIView * _Nonnull (^)(NSArray<id> * _Nonnull))children {
    return ^(NSArray<id> *items) {
        NSMutableArray *$items = [NSMutableArray arrayWithArray:items];
        for (int i = 0; i < items.count; i++) {
            id item = items[i];
            if ([item isKindOfClass:[$AbstractBuilder class]]) {
                $AbstractBuilder *builder = ($AbstractBuilder *)item;
                [$items replaceObjectAtIndex:i withObject:builder.EOB];
            } else if (![item isKindOfClass:[UIView class]]) {
                NSAssert(false, @"item must be a uiview or itembuilder");
            }
        }
        UICollectionView *product = [UICollectionView jun_collectionViewWithItems:[$items copy] direction:self.$isHorizontal];
        return [self _wrapProduct:product];
    };
}

- (UIView * _Nonnull (^)(NSArray<id> * _Nonnull (^ _Nonnull)(void)))build {
    return ^(NSArray<id> * (^builder)(void)) {
        NSArray<id> *(^$builder)(void) = ^(void) {
            NSArray *items = [NSMutableArray arrayWithArray:builder()];
            NSMutableArray *$items = [NSMutableArray arrayWithArray:items];
            for (int i = 0; i < items.count; i++) {
                id item = items[i];
                if ([item isKindOfClass:[$AbstractBuilder class]]) {
                    $AbstractBuilder *builder = ($AbstractBuilder *)item;
                    [$items replaceObjectAtIndex:i withObject:builder.EOB];
                } else if (![item isKindOfClass:[UIView class]]) {
                    NSAssert(false, @"item must be a uiview or itembuilder");
                }
            }
            return [$items copy];
        };
        UICollectionView *product = [UICollectionView jun_collectionViewWithItemsBuilder:$builder direction:self.$isHorizontal];
        return [self _wrapProduct:product];
    };
}

- (UIView * _Nonnull (^)(NSArray * _Nonnull, id _Nonnull (^ _Nonnull)(NSUInteger, id _Nonnull)))forEach {
    return ^(NSArray *elements, id (^builder)(NSUInteger i, id each)) {
        UIView *(^$builder)(NSUInteger i, id each) = ^(NSUInteger i, id each) {
            id item = builder(i, each);
            if ([item isKindOfClass:[$AbstractBuilder class]]) {
                $AbstractBuilder *builder = ($AbstractBuilder *)item;
                return builder.EOB;
            } else if (![item isKindOfClass:[UIView class]]) {
                NSAssert(false, @"item must be a uiview or itembuilder");
            }
            return item;
        };
        UICollectionView *product = [UICollectionView jun_collectionViewWithForEach:elements itemBuilder:$builder direction:self.$isHorizontal];
        return [self _wrapProduct:product];
    };
}

- (UIView * _Nonnull (^)(NSUInteger, id _Nonnull (^ _Nonnull)(NSUInteger)))count {
    return ^(NSUInteger count, UIView *(^builder)(NSUInteger)) {
        UIView *(^$builder)(NSUInteger i) = ^(NSUInteger i) {
            id item = builder(i);
            if ([item isKindOfClass:[$AbstractBuilder class]]) {
                $AbstractBuilder *builder = ($AbstractBuilder *)item;
                return builder.EOB;
            } else if (![item isKindOfClass:[UIView class]]) {
                NSAssert(false, @"item must be a uiview or itembuilder");
            }
            return item;
        };
        UICollectionView *product = [UICollectionView jun_collectionViewWithItemCount:count itemBuilder:$builder direction:self.$isHorizontal];
        return [self _wrapProduct:product];
    };
}

- (UIView * _Nonnull (^)(NSUInteger (^ _Nonnull)(void), id _Nonnull (^ _Nonnull)(NSUInteger)))countBy {
    return ^(NSUInteger (^count)(void), id (^builder)(NSUInteger)) {
        UIView *(^$builder)(NSUInteger i) = ^(NSUInteger i) {
            id item = builder(i);
            if ([item isKindOfClass:[$AbstractBuilder class]]) {
                $AbstractBuilder *builder = ($AbstractBuilder *)item;
                return builder.EOB;
            } else if (![item isKindOfClass:[UIView class]]) {
                NSAssert(false, @"item must be a uiview or itembuilder");
            }
            return item;
        };
        UICollectionView *product = [UICollectionView jun_collectionViewWithItemCountBuilder:count itemBuilder:$builder direction:self.$isHorizontal];
        return [self _wrapProduct:product];
    };
}

- (UIView *)_wrapProduct:(UICollectionView *)product {
    product.translatesAutoresizingMaskIntoConstraints = false;
    product.jun_minimumInteritemSpacing = self.$itemSpacing;
    product.jun_minimumLineSpacing = self.$lineSpacing;
    product.jun_itemSize = self.$itemSize;
    
    product.alwaysBounceVertical = !self.$isHorizontal ? self.$isAlwaysBounce : false;
    product.alwaysBounceHorizontal = self.$isHorizontal ? self.$isAlwaysBounce : false;
    
    product.showsVerticalScrollIndicator = !self.$isHorizontal ? self.$isShowIndicator : false;
    product.showsHorizontalScrollIndicator = self.$isHorizontal ? self.$isShowIndicator : false;
    
    self.$product.translatesAutoresizingMaskIntoConstraints = false;
    [self.$product addSubview:product];
    [self.$product addConstraints:@[
        
        [NSLayoutConstraint constraintWithItem:product attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.$product attribute:NSLayoutAttributeTop multiplier:1.0f constant:0.0f],
        [NSLayoutConstraint constraintWithItem:product attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.$product attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0.0f],
        [NSLayoutConstraint constraintWithItem:product attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.$product attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0.0f],
        [NSLayoutConstraint constraintWithItem:product attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.$product attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0.0f],
    ]];
    return self.EOB;
}

@end

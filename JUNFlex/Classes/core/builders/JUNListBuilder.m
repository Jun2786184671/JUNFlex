//
//  JUNListBuilder.m
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/30.
//

#import "JUNAbstractBuilder+Private.h"
#import "JUNListBuilder.h"
#import "JUNItem.h"
#import "UICollectionView+JUNex.h"

@interface JUNListBuilder ()

@property(nonatomic, strong) JUNItem *list;

@property(nonatomic, assign) bool mask_bounds;
@property(nonatomic, assign) CGSize item_size;
@property(nonatomic, assign) CGFloat item_spacing;
@property(nonatomic, assign) CGFloat line_spacing;
@property(nonatomic, assign) bool is_horizontal;
@property(nonatomic, assign) bool is_always_bounce;
@property(nonatomic, assign) bool is_show_indicator;

@end

@implementation JUNListBuilder

+ (void)load {
    [super load];
}

+ (NSString *)type {
    return @"list";
}

- (id)product {
    return self.list;
}

- (JUNItem *)list {
    if (_list == nil) {
        _list = [[JUNItem alloc] init];
    }
    return _list;
}

- (JUNListBuilder * _Nonnull (^)(bool))horizontal {
    return ^(bool isHorizontal) {
        self.is_horizontal = isHorizontal;
        return self;
    };
}

- (JUNListBuilder * _Nonnull (^)(bool))alwaysBounce {
    return ^(bool isAlwaysBounce) {
        self.is_always_bounce = isAlwaysBounce;
        return self;
    };
}

- (JUNListBuilder * _Nonnull (^)(bool))showIndicator {
    return ^(bool isShowIndicator) {
        self.is_show_indicator = isShowIndicator;
        return self;
    };
}

- (JUNListBuilder * _Nonnull (^)(CGFloat, CGFloat))itemSize {
    return ^(CGFloat width, CGFloat height) {
        self.item_size = CGSizeMake(width, height);
        return self;
    };
}

- (JUNListBuilder * _Nonnull (^)(CGFloat))itemSpacing {
    return ^(CGFloat itemSpacing) {
        self.item_spacing = itemSpacing;
        return self;
    };
}

- (JUNListBuilder * _Nonnull (^)(CGFloat))lineSpacing {
    return ^(CGFloat lineSpacing) {
        self.line_spacing = lineSpacing;
        return self;
    };
}

- (UIView * _Nonnull (^)(NSArray<id> * _Nonnull))children {
    return ^(NSArray<id> *items) {
        NSMutableArray *validItems = [NSMutableArray arrayWithArray:items];
        for (int i = 0; i < items.count; i++) {
            id item = items[i];
            if ([item isKindOfClass:[JUNAbstractBuilder class]]) {
                JUNAbstractBuilder *builder = (JUNAbstractBuilder *)item;
                [validItems replaceObjectAtIndex:i withObject:builder.EOB];
            } else if (![item isKindOfClass:[UIView class]]) {
                NSAssert(false, @"item must be a uiview or itembuilder");
            }
        }
        UICollectionView *product = [UICollectionView jun_collectionViewWithItems:[validItems copy] direction:self.is_horizontal];
        return [self _wrapProduct:product];
    };
}

- (UIView * _Nonnull (^)(NSArray<id> * _Nonnull (^ _Nonnull)(void)))build {
    return ^(NSArray<id> * (^builder)(void)) {
        NSArray<id> *(^validBuilder)(void) = ^(void) {
            NSArray *items = [NSMutableArray arrayWithArray:builder()];
            NSMutableArray *validItems = [NSMutableArray arrayWithArray:items];
            for (int i = 0; i < items.count; i++) {
                id item = items[i];
                if ([item isKindOfClass:[JUNAbstractBuilder class]]) {
                    JUNAbstractBuilder *builder = (JUNAbstractBuilder *)item;
                    [validItems replaceObjectAtIndex:i withObject:builder.EOB];
                } else if (![item isKindOfClass:[UIView class]]) {
                    NSAssert(false, @"item must be a uiview or itembuilder");
                }
            }
            return [validItems copy];
        };
        UICollectionView *product = [UICollectionView jun_collectionViewWithItemsBuilder:validBuilder direction:self.is_horizontal];
        return [self _wrapProduct:product];
    };
}

- (UIView * _Nonnull (^)(NSArray * _Nonnull, id _Nonnull (^ _Nonnull)(NSUInteger, id _Nonnull)))forEach {
    return ^(NSArray *elements, id (^builder)(NSUInteger i, id each)) {
        UIView *(^validBuilder)(NSUInteger i, id each) = ^(NSUInteger i, id each) {
            id item = builder(i, each);
            if ([item isKindOfClass:[JUNAbstractBuilder class]]) {
                JUNAbstractBuilder *builder = (JUNAbstractBuilder *)item;
                return builder.EOB;
            } else if (![item isKindOfClass:[UIView class]]) {
                NSAssert(false, @"item must be a uiview or itembuilder");
            }
            return item;
        };
        UICollectionView *product = [UICollectionView jun_collectionViewWithForEach:elements itemBuilder:validBuilder direction:self.is_horizontal];
        return [self _wrapProduct:product];
    };
}

- (UIView * _Nonnull (^)(NSUInteger, id _Nonnull (^ _Nonnull)(NSUInteger)))count {
    return ^(NSUInteger count, UIView *(^builder)(NSUInteger)) {
        UIView *(^validBuilder)(NSUInteger i) = ^(NSUInteger i) {
            id item = builder(i);
            if ([item isKindOfClass:[JUNAbstractBuilder class]]) {
                JUNAbstractBuilder *builder = (JUNAbstractBuilder *)item;
                return builder.EOB;
            } else if (![item isKindOfClass:[UIView class]]) {
                NSAssert(false, @"item must be a uiview or itembuilder");
            }
            return item;
        };
        UICollectionView *product = [UICollectionView jun_collectionViewWithItemCount:count itemBuilder:validBuilder direction:self.is_horizontal];
        return [self _wrapProduct:product];
    };
}

- (UIView * _Nonnull (^)(NSUInteger (^ _Nonnull)(void), id _Nonnull (^ _Nonnull)(NSUInteger)))countBy {
    return ^(NSUInteger (^count)(void), id (^builder)(NSUInteger)) {
        UIView *(^validBuilder)(NSUInteger i) = ^(NSUInteger i) {
            id item = builder(i);
            if ([item isKindOfClass:[JUNAbstractBuilder class]]) {
                JUNAbstractBuilder *builder = (JUNAbstractBuilder *)item;
                return builder.EOB;
            } else if (![item isKindOfClass:[UIView class]]) {
                NSAssert(false, @"item must be a uiview or itembuilder");
            }
            return item;
        };
        UICollectionView *product = [UICollectionView jun_collectionViewWithItemCountBuilder:count itemBuilder:validBuilder direction:self.is_horizontal];
        return [self _wrapProduct:product];
    };
}

- (UIView *)_wrapProduct:(UICollectionView *)product {
    product.translatesAutoresizingMaskIntoConstraints = false;
    product.jun_minimumInteritemSpacing = self.item_spacing;
    product.jun_minimumLineSpacing = self.line_spacing;
    product.jun_itemSize = self.item_size;
    
    product.alwaysBounceVertical = !self.is_horizontal ? self.is_always_bounce : false;
    product.alwaysBounceHorizontal = self.is_horizontal ? self.is_always_bounce : false;
    
    product.showsVerticalScrollIndicator = !self.is_horizontal ? self.is_show_indicator : false;
    product.showsHorizontalScrollIndicator = self.is_horizontal ? self.is_show_indicator : false;
    
    self.list.translatesAutoresizingMaskIntoConstraints = false;
    [self.list addSubview:product];
    [self.list addConstraints:@[
        
        [NSLayoutConstraint constraintWithItem:product attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.list attribute:NSLayoutAttributeTop multiplier:1.0f constant:0.0f],
        [NSLayoutConstraint constraintWithItem:product attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.list attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0.0f],
        [NSLayoutConstraint constraintWithItem:product attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.list attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0.0f],
        [NSLayoutConstraint constraintWithItem:product attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.list attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0.0f],
    ]];
    return self.EOB;
}

@end

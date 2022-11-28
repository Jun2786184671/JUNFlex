//
//  JUNListBuilder.m
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/30.
//

#import "JUNListBuilder.h"
#import "JUNItemBuilder.h"
#import "UICollectionView+JUNex.h"

@interface JUNListBuilder ()

@property(nonatomic, copy) NSString *$ID;
@property(nonatomic, strong) UIColor *$color;
@property(nonatomic, assign) CGFloat $alpha;
@property(nonatomic, assign) CGFloat $radius;
@property(nonatomic, assign) CGFloat $width;
@property(nonatomic, assign) CGFloat $height;
@property(nonatomic, assign) bool $maskBounds;
@property(nonatomic, assign) CGSize $itemSize;
@property(nonatomic, assign) CGFloat $itemSpacing;
@property(nonatomic, assign) CGFloat $lineSpacing;
@property(nonatomic, assign) bool $isHorizontal;
@property(nonatomic, assign) bool $isAlwaysBounce;
@property(nonatomic, assign) bool $isShowIndicator;

@end

@implementation JUNListBuilder

- (JUNListBuilder * _Nonnull (^)(NSString * _Nonnull))ID {
    return ^(NSString *ID) {
        self.$ID = ID;
        return self;
    };
}

- (JUNListBuilder * _Nonnull (^)(UIColor * _Nonnull))color {
    return ^(UIColor *color) {
        self.$color = color;
        return self;
    };
}

- (JUNListBuilder * _Nonnull (^)(CGFloat))radius {
    return ^(CGFloat radius) {
        self.$radius = radius;
        return self;
    };
}

- (JUNListBuilder * _Nonnull (^)(bool))maskBounds {
    return ^(bool maskBounds) {
        self.$maskBounds = maskBounds;
        return self;
    };
}

- (JUNListBuilder * _Nonnull (^)(CGFloat))alpha {
    return ^(CGFloat alpha) {
        self.$alpha = alpha;
        return self;
    };
}

- (JUNListBuilder * _Nonnull (^)(CGFloat))width {
    return ^(CGFloat width) {
        self.$width = width;
        return self;
    };
}

- (JUNListBuilder * _Nonnull (^)(CGFloat))height {
    return ^(CGFloat height) {
        self.$height = height;
        return self;
    };
}

- (JUNListBuilder * _Nonnull (^)(CGSize))size {
    return ^(CGSize size) {
        self.width(size.width);
        self.height(size.height);
        return self;
    };
}

- (JUNListBuilder * _Nonnull (^)(bool))horizontal {
    return ^(bool isHorizontal) {
        self.$isHorizontal = isHorizontal;
        return self;
    };
}

- (JUNListBuilder * _Nonnull (^)(bool))alwaysBounce {
    return ^(bool isAlwaysBounce) {
        self.$isAlwaysBounce = isAlwaysBounce;
        return self;
    };
}

- (JUNListBuilder * _Nonnull (^)(bool))showIndicator {
    return ^(bool isShowIndicator) {
        self.$isShowIndicator = isShowIndicator;
        return self;
    };
}

- (JUNListBuilder * _Nonnull (^)(CGSize))itemSize {
    return ^(CGSize itemSize) {
        self.$itemSize = itemSize;
        return self;
    };
}

- (JUNListBuilder * _Nonnull (^)(CGFloat))itemSpacing {
    return ^(CGFloat itemSpacing) {
        self.$itemSpacing = itemSpacing;
        return self;
    };
}

- (JUNListBuilder * _Nonnull (^)(CGFloat))lineSpacing {
    return ^(CGFloat lineSpacing) {
        self.$lineSpacing = lineSpacing;
        return self;
    };
}

- (UIView * _Nonnull (^)(NSArray<id> * _Nonnull))children {
    return ^(NSArray<id> *items) {
        NSMutableArray *validItems = [NSMutableArray arrayWithArray:items];
        for (int i = 0; i < items.count; i++) {
            id item = items[i];
            if ([item isKindOfClass:[JUNItemBuilder class]]) {
                JUNItemBuilder *builder = (JUNItemBuilder *)item;
                [validItems replaceObjectAtIndex:i withObject:builder.end];
            } else if (![item isKindOfClass:[UIView class]]) {
                NSAssert(false, @"item must be a uiview or itembuilder");
            }
        }
        UICollectionView *listView = [UICollectionView jun_collectionViewWithItems:validItems direction:self.$isHorizontal];
        [self _configListView:listView];
        return listView;
    };
}

- (UIView * _Nonnull (^)(NSArray<id> * _Nonnull (^ _Nonnull)(void)))build {
    return ^(NSArray<id> * (^builder)(void)) {
        NSArray<UIView *> *(^wrappedBuilder)(void) = ^(void) {
            NSArray *items = [NSMutableArray arrayWithArray:builder()];
            NSMutableArray *validItems = [NSMutableArray arrayWithArray:items];
            for (int i = 0; i < items.count; i++) {
                id item = items[i];
                if ([item isKindOfClass:[JUNItemBuilder class]]) {
                    JUNItemBuilder *builder = (JUNItemBuilder *)item;
                    [validItems replaceObjectAtIndex:i withObject:builder.end];
                } else if (![item isKindOfClass:[UIView class]]) {
                    NSAssert(false, @"item must be a uiview or itembuilder");
                }
            }
            return [validItems copy];
        };
        UICollectionView *listView = [UICollectionView jun_collectionViewWithItemsBuilder:wrappedBuilder direction:self.$isHorizontal];
        [self _configListView:listView];
        return listView;
    };
}

- (UIView * _Nonnull (^)(NSArray * _Nonnull, id _Nonnull (^ _Nonnull)(NSUInteger, id _Nonnull)))forEach {
    return ^(NSArray *elements, id (^builder)(NSUInteger i, id each)) {
        UIView *(^wrappedBuilder)(NSUInteger i, id each) = ^(NSUInteger i, id each) {
            id item = builder(i, each);
            if ([item isKindOfClass:[JUNItemBuilder class]]) {
                JUNItemBuilder *builder = (JUNItemBuilder *)item;
                return builder.end;
            } else if (![item isKindOfClass:[UIView class]]) {
                NSAssert(false, @"item must be a uiview or itembuilder");
            }
            return (UIView *)item;
        };
        UICollectionView *listView = [UICollectionView jun_collectionViewWithForEach:elements itemBuilder:wrappedBuilder direction:self.$isHorizontal];
        [self _configListView:listView];
        return listView;
    };
}

- (UIView * _Nonnull (^)(NSUInteger, id _Nonnull (^ _Nonnull)(NSUInteger)))count {
    return ^(NSUInteger count, UIView *(^builder)(NSUInteger)) {
        UIView *(^wrappedBuilder)(NSUInteger i) = ^(NSUInteger i) {
            id item = builder(i);
            if ([item isKindOfClass:[JUNItemBuilder class]]) {
                JUNItemBuilder *builder = (JUNItemBuilder *)item;
                return builder.end;
            } else if (![item isKindOfClass:[UIView class]]) {
                NSAssert(false, @"item must be a uiview or itembuilder");
            }
            return (UIView *)item;
        };
        UICollectionView *listView = [UICollectionView jun_collectionViewWithItemCount:count itemBuilder:wrappedBuilder direction:self.$isHorizontal];
        [self _configListView:listView];
        return listView;
    };
}

- (UIView * _Nonnull (^)(NSUInteger (^ _Nonnull)(void), id _Nonnull (^ _Nonnull)(NSUInteger)))countBy {
    return ^(NSUInteger (^count)(void), UIView *(^builder)(NSUInteger)) {
        UIView *(^wrappedBuilder)(NSUInteger i) = ^(NSUInteger i) {
            id item = builder(i);
            if ([item isKindOfClass:[JUNItemBuilder class]]) {
                JUNItemBuilder *builder = (JUNItemBuilder *)item;
                return builder.end;
            } else if (![item isKindOfClass:[UIView class]]) {
                NSAssert(false, @"item must be a uiview or itembuilder");
            }
            return (UIView *)item;
        };
        UICollectionView *listView = [UICollectionView jun_collectionViewWithItemCountBuilder:count itemBuilder:wrappedBuilder direction:self.$isHorizontal];
        [self _configListView:listView];
        return listView;
        
    };
}

- (void)_configListView:(UICollectionView *)listView {
    listView.translatesAutoresizingMaskIntoConstraints = false;
    listView.jun_minimumInteritemSpacing = self.$itemSpacing;
    listView.jun_minimumLineSpacing = self.$lineSpacing;
    listView.jun_itemSize = self.$itemSize;
    
    listView.alwaysBounceVertical = !self.$isHorizontal ? self.$isAlwaysBounce : false;
    listView.alwaysBounceHorizontal = self.$isHorizontal ? self.$isAlwaysBounce : false;
    
    listView.showsVerticalScrollIndicator = !self.$isHorizontal ? self.$isShowIndicator : false;
    listView.showsHorizontalScrollIndicator = self.$isHorizontal ? self.$isShowIndicator : false;
    
    CGRect frame = listView.frame;
    
    if (self.$width) {
        NSLayoutConstraint *wConstraint = [NSLayoutConstraint constraintWithItem:listView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:self.$width];
        wConstraint.priority = UILayoutPriorityDefaultHigh;
        [listView addConstraints:@[
            [NSLayoutConstraint constraintWithItem:listView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:self.$width],
            wConstraint,
        ]];
        frame.size.width = self.$width;
    }
    if (self.$height) {
        NSLayoutConstraint *hConstraint = [NSLayoutConstraint constraintWithItem:listView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:self.$height];
        hConstraint.priority = UILayoutPriorityDefaultHigh;
        [listView addConstraints:@[
            [NSLayoutConstraint constraintWithItem:listView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:self.$height],
            hConstraint,
        ]];
        frame.size.height = self.$height;
    }
    
    listView.frame = frame;
    
    if (self.$ID) {
        listView.accessibilityIdentifier = self.$ID;
    }
    if (self.$radius) {
        listView.layer.cornerRadius = self.$radius;
    }
    
    listView.layer.masksToBounds = self.$maskBounds;
    
    if (self.$color) {
        listView.backgroundColor = self.$color;
    }
    if (self.$alpha) {
        listView.alpha = self.$alpha;
    }
    
}

@end

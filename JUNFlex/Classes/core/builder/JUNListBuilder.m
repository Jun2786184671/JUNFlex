//
//  JUNListBuilder.m
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/30.
//

#import "JUNListBuilder.h"
#import "JUNItemBuilder+Private.h"
#import "UICollectionView+JUNex.h"

@interface JUNListBuilder ()

@property(nonatomic, assign) bool $maskBounds;
@property(nonatomic, assign) CGSize $itemSize;
@property(nonatomic, assign) CGFloat $itemSpacing;
@property(nonatomic, assign) CGFloat $lineSpacing;
@property(nonatomic, assign) bool $isHorizontal;
@property(nonatomic, assign) bool $isAlwaysBounce;
@property(nonatomic, assign) bool $isShowIndicator;

@end

@implementation JUNListBuilder

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
        return [self _wrapListView:listView];
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
        return [self _wrapListView:listView];
    };
}

- (UIView * _Nonnull (^)(NSArray * _Nonnull, id _Nonnull (^ _Nonnull)(NSUInteger, id _Nonnull)))forEach {
    return ^(NSArray *elements, UIView *(^builder)(NSUInteger i, id each)) {
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
        return [self _wrapListView:listView];
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
        return [self _wrapListView:listView];
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
        return [self _wrapListView:listView];
    };
}

- (UIView *)_wrapListView:(UICollectionView *)listView {
    listView.translatesAutoresizingMaskIntoConstraints = false;
    listView.jun_minimumInteritemSpacing = self.$itemSpacing;
    listView.jun_minimumLineSpacing = self.$lineSpacing;
    listView.jun_itemSize = self.$itemSize;
    
    listView.alwaysBounceVertical = !self.$isHorizontal ? self.$isAlwaysBounce : false;
    listView.alwaysBounceHorizontal = self.$isHorizontal ? self.$isAlwaysBounce : false;
    
    listView.showsVerticalScrollIndicator = !self.$isHorizontal ? self.$isShowIndicator : false;
    listView.showsHorizontalScrollIndicator = self.$isHorizontal ? self.$isShowIndicator : false;
    
    self.target.translatesAutoresizingMaskIntoConstraints = false;
    [self.target addSubview:listView];
    [self.target addConstraints:@[
        
        [NSLayoutConstraint constraintWithItem:listView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.target attribute:NSLayoutAttributeTop multiplier:1.0f constant:0.0f],
        [NSLayoutConstraint constraintWithItem:listView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.target attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0.0f],
        [NSLayoutConstraint constraintWithItem:listView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.target attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0.0f],
        [NSLayoutConstraint constraintWithItem:listView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.target attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0.0f],
    ]];
    return self.end;
}

@end

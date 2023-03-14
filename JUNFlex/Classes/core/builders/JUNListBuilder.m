//
//  JUNListBuilder.m
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/30.
//

#import "JUNListBuilder.h"
#import "JUNBaseBuilder+Private.h"
#import "JUNList.h"
#import "JUNListProperty.h"
#import "JUNPropertyParser.h"
#import "UICollectionView+JUNex.h"

@interface JUNListBuilder ()

@property(nonatomic, strong) JUNList *list;
@property(nonatomic, strong) JUNListProperty *listProperty;

@end

@implementation JUNListBuilder

- (id)product {
    return self.list;
}

- (__kindof JUNBaseProperty *)property {
    return self.listProperty;
}

- (JUNList *)list {
    if (!_list) {
        _list = [[JUNList alloc] init];
    }
    return _list;
}

- (JUNListProperty *)listProperty {
    if (!_listProperty) {
        _listProperty = [[JUNListProperty alloc] init];
    }
    return _listProperty;
}

- (JUNListBuilder * _Nonnull (^)(id))horizontal {
    return ^(id value) {
        self.listProperty.horizontal = [[JUNPropertyParser sharedParser] parseBoolWithValue:value];
        return self;
    };
}

- (JUNListBuilder * _Nonnull (^)(id))alwaysBounce {
    return ^(id value) {
        self.listProperty.alwaysBounce = [[JUNPropertyParser sharedParser] parseBoolWithValue:value];
        return self;
    };
}

- (JUNListBuilder * _Nonnull (^)(id))showIndicator {
    return ^(id value) {
        self.listProperty.showIndicator = [[JUNPropertyParser sharedParser] parseBoolWithValue:value];
        return self;
    };
}

- (JUNListBuilder * _Nonnull (^)(id, ...))itemSize {
    return ^(id arg, ...) {
        JUNSizeProperty *itemSize = [[JUNSizeProperty alloc] init];
        va_list args;
        va_start(args, arg);
        itemSize.width = [[JUNPropertyParser sharedParser] parseFloatWithValue:arg];
        itemSize.height = [[JUNPropertyParser sharedParser] parseFloatWithValue:va_arg(args, id) ?: arg];
        va_end(args);
        self.listProperty.itemSize = itemSize;
        return self;
    };
}

- (JUNListBuilder * _Nonnull (^)(id))itemSpacing {
    return ^(id value) {
        self.listProperty.itemSpacing = [[JUNPropertyParser sharedParser] parseFloatWithValue:value];
        return self;
    };
}

- (JUNListBuilder * _Nonnull (^)(id))lineSpacing {
    return ^(id value) {
        self.listProperty.lineSpacing = [[JUNPropertyParser sharedParser] parseFloatWithValue:value];
        return self;
    };
}

- (__kindof UIView * _Nonnull (^)(NSArray<id> * _Nonnull))children {
    return ^(NSArray<id> *children) {
        NSMutableArray *childrenViews = [NSMutableArray arrayWithArray:children];
        for (int i = 0; i < children.count; i++) {
            id child = children[i];
            if ([child isKindOfClass:[JUNBaseBuilder class]]) {
                JUNBaseBuilder *builder = (JUNBaseBuilder *)child;
                [childrenViews replaceObjectAtIndex:i withObject:builder.EOB];
            } else if (![child isKindOfClass:[UIView class]]) {
                NSAssert(false, @"children must be uiviews or builders");
            }
        }
        self.listProperty.childrenViews = childrenViews;
        UICollectionView *target = [UICollectionView jun_collectionViewWithItems:[childrenViews copy] direction:[self.listProperty.horizontal boolValue]];
        return [self _wrapTarget:target];
    };
}

- (__kindof UIView * _Nonnull (^)(NSArray<id> * _Nonnull (^ _Nonnull)(void)))build {
    return ^(NSArray<id> * (^builder)(void)) {
        NSArray<id> *(^validBuilder)(void) = ^(void) {
            NSArray *items = [NSMutableArray arrayWithArray:builder()];
            NSMutableArray *validItems = [NSMutableArray arrayWithArray:items];
            for (int i = 0; i < items.count; i++) {
                id item = items[i];
                if ([item isKindOfClass:[JUNBaseBuilder class]]) {
                    JUNBaseBuilder *builder = (JUNBaseBuilder *)item;
                    [validItems replaceObjectAtIndex:i withObject:builder.EOB];
                } else if (![item isKindOfClass:[UIView class]]) {
                    NSAssert(false, @"item must be a uiview or itembuilder");
                }
            }
            return [validItems copy];
        };
        UICollectionView *target = [UICollectionView jun_collectionViewWithItemsBuilder:validBuilder direction:[self.listProperty.horizontal boolValue]];
        return [self _wrapTarget:target];
    };
}

- (__kindof UIView * _Nonnull (^)(NSArray * _Nonnull, id _Nonnull (^ _Nonnull)(NSUInteger, id _Nonnull)))forEach {
    return ^(NSArray *elements, id (^builder)(NSUInteger i, id each)) {
        UIView *(^validBuilder)(NSUInteger i, id each) = ^(NSUInteger i, id each) {
            id item = builder(i, each);
            if ([item isKindOfClass:[JUNBaseBuilder class]]) {
                JUNBaseBuilder *builder = (JUNBaseBuilder *)item;
                return builder.EOB;
            } else if (![item isKindOfClass:[UIView class]]) {
                NSAssert(false, @"item must be a uiview or itembuilder");
            }
            return item;
        };
        UICollectionView *target = [UICollectionView jun_collectionViewWithForEach:elements itemBuilder:validBuilder direction:[self.listProperty.horizontal boolValue]];
        return [self _wrapTarget:target];
    };
}

- (__kindof UIView * _Nonnull (^)(NSUInteger, id _Nonnull (^ _Nonnull)(NSUInteger)))count {
    return ^(NSUInteger count, UIView *(^builder)(NSUInteger)) {
        UIView *(^validBuilder)(NSUInteger i) = ^(NSUInteger i) {
            id item = builder(i);
            if ([item isKindOfClass:[JUNBaseBuilder class]]) {
                JUNBaseBuilder *builder = (JUNBaseBuilder *)item;
                return builder.EOB;
            } else if (![item isKindOfClass:[UIView class]]) {
                NSAssert(false, @"item must be a uiview or itembuilder");
            }
            return item;
        };
        UICollectionView *target = [UICollectionView jun_collectionViewWithItemCount:count itemBuilder:validBuilder direction:[self.listProperty.horizontal boolValue]];
        return [self _wrapTarget:target];
    };
}

- (__kindof UIView * _Nonnull (^)(NSUInteger (^ _Nonnull)(void), id _Nonnull (^ _Nonnull)(NSUInteger)))countBy {
    return ^(NSUInteger (^count)(void), id (^builder)(NSUInteger)) {
        UIView *(^validBuilder)(NSUInteger i) = ^(NSUInteger i) {
            id item = builder(i);
            if ([item isKindOfClass:[JUNBaseBuilder class]]) {
                JUNBaseBuilder *builder = (JUNBaseBuilder *)item;
                return builder.EOB;
            } else if (![item isKindOfClass:[UIView class]]) {
                NSAssert(false, @"item must be a uiview or itembuilder");
            }
            return item;
        };
        UICollectionView *target = [UICollectionView jun_collectionViewWithItemCountBuilder:count itemBuilder:validBuilder direction:[self.listProperty.horizontal boolValue]];
        return [self _wrapTarget:target];
    };
}

- (JUNList *)_wrapTarget:(UICollectionView *)target {
    self.list.target = target;
    return self.EOB;
}

@end

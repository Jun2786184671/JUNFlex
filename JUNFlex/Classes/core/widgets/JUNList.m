//
//  JUNList.m
//  JUNFlex
//
//  Created by Jun Ma on 2022/12/11.
//

#import "JUNList.h"
#import "JUNListProperty.h"
#import "JUNSerializer.h"
#import <JUNCollectionView/UICollectionView+JUNex.h>

@implementation JUNList
JUN_REGISTER_CLASS(@"list", [JUNListProperty class]);

- (void)jun_setProperty:(__kindof JUNBaseProperty *)property {
    if ([property isEqual:self.jun_property]) return;
    [super jun_setProperty:property];
    if (![property isKindOfClass:[JUNListProperty class]]) return;
    JUNListProperty *listProperty = property;
    
    BOOL isHorizontal = [listProperty.horizontal boolValue];
    if (!self.target && listProperty.childrenProperties) {
        NSParameterAssert(listProperty.childrenViews);
        self.target = [UICollectionView jun_collectionViewWithItems:listProperty.childrenViews direction:isHorizontal ? UICollectionViewScrollDirectionHorizontal : UICollectionViewScrollDirectionVertical];
    }
    
    self.target.jun_minimumInteritemSpacing = [listProperty.itemSpacing floatValue];
    self.target.jun_minimumLineSpacing = [listProperty.lineSpacing floatValue];
    
    JUNSizeProperty *itemSize = listProperty.itemSize;
    self.target.jun_itemSize = CGSizeMake([itemSize.width floatValue], [itemSize.height floatValue]);
    
    BOOL isAlwaysBounce = [listProperty.alwaysBounce boolValue];
    BOOL isShowIndicator = [listProperty.showIndicator boolValue];
    self.target.alwaysBounceVertical = !isHorizontal ? isAlwaysBounce : false;
    self.target.alwaysBounceHorizontal = isHorizontal ? isAlwaysBounce : false;
    self.target.showsVerticalScrollIndicator = !isHorizontal ? isShowIndicator : false;
    self.target.showsHorizontalScrollIndicator = isHorizontal ? isShowIndicator : false;
}

- (void)setTarget:(UICollectionView *)target {
    if ([target isEqual:self.target]) return;
    if (self.target) {
        [self.target removeFromSuperview];
    }
    target.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:target];
    [self addConstraints:@[
        [NSLayoutConstraint constraintWithItem:target attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0f constant:0.0f],
        [NSLayoutConstraint constraintWithItem:target attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0.0f],
        [NSLayoutConstraint constraintWithItem:target attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0.0f],
        [NSLayoutConstraint constraintWithItem:target attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0.0f],
    ]];
    _target = target;
}

@end

//
//  JUNListBuilder.h
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/30.
//

#import "JUNAbstractBuilder.h"

@class JUNListBuilder;

NS_ASSUME_NONNULL_BEGIN

@interface JUNListBuilder : JUNAbstractBuilder<JUNListBuilder *, UICollectionView *>

@property(nonatomic, readonly) JUNListBuilder *(^itemSize)(CGFloat width, CGFloat height);
@property(nonatomic, readonly) JUNListBuilder *(^itemSpacing)(CGFloat itemSpacing);
@property(nonatomic, readonly) JUNListBuilder *(^lineSpacing)(CGFloat lineSpacing);
@property(nonatomic, readonly) JUNListBuilder *(^horizontal)(bool isHorizontal);
@property(nonatomic, readonly) JUNListBuilder *(^alwaysBounce)(bool isAlwaysBounce);
@property(nonatomic, readonly) JUNListBuilder *(^showIndicator)(bool isShowIndicator);

@property(nonatomic, readonly) UICollectionView *(^children)(NSArray<id> *children);
@property(nonatomic, readonly) UICollectionView *(^forEach)(NSArray *elements, id (^builder)(NSUInteger i, id each));
@property(nonatomic, readonly) UICollectionView *(^build)(NSArray<id> *(^builder)(void));
@property(nonatomic, readonly) UICollectionView *(^count)(NSUInteger count, id (^builder)(NSUInteger i));
@property(nonatomic, readonly) UICollectionView *(^countBy)(NSUInteger (^count)(void), id (^builder)(NSUInteger i));

@end

NS_ASSUME_NONNULL_END

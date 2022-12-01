//
//  JUNListBuilder.h
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/30.
//

#import "$ItemBuilder.h"

NS_ASSUME_NONNULL_BEGIN

@interface $ListBuilder : $ItemBuilder

@property(nonatomic, readonly) $ListBuilder *(^ID)(NSString *identifier);
@property(nonatomic, readonly) $ListBuilder *(^color)(UIColor *color);
@property(nonatomic, readonly) $ListBuilder *(^radius)(CGFloat radius);
@property(nonatomic, readonly) $ListBuilder *(^maskBounds)(bool isMaskBounds);
@property(nonatomic, readonly) $ListBuilder *(^alpha)(CGFloat alpha);
@property(nonatomic, readonly) $ListBuilder *(^width)(CGFloat width);
@property(nonatomic, readonly) $ListBuilder *(^height)(CGFloat height);
@property(nonatomic, readonly) $ListBuilder *(^size)(CGSize size);


@property(nonatomic, readonly) $ListBuilder *(^itemSize)(CGSize itemSize);
@property(nonatomic, readonly) $ListBuilder *(^itemSpacing)(CGFloat itemSpacing);
@property(nonatomic, readonly) $ListBuilder *(^lineSpacing)(CGFloat lineSpacing);
@property(nonatomic, readonly) $ListBuilder *(^horizontal)(bool isHorizontal);
@property(nonatomic, readonly) $ListBuilder *(^alwaysBounce)(bool isAlwaysBounce);
@property(nonatomic, readonly) $ListBuilder *(^showIndicator)(bool isShowIndicator);

@property(nonatomic, readonly) UIView *(^children)(NSArray<id> *items);
@property(nonatomic, readonly) UIView *(^forEach)(NSArray *elements, id (^builder)(NSUInteger i, id each));
@property(nonatomic, readonly) UIView *(^build)(NSArray<id> *(^builder)(void));
@property(nonatomic, readonly) UIView *(^count)(NSUInteger count, id (^builder)(NSUInteger i));
@property(nonatomic, readonly) UIView *(^countBy)(NSUInteger (^count)(void), id (^builder)(NSUInteger i));

@end

NS_ASSUME_NONNULL_END

//
//  $ListBuilder.h
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/30.
//

#import "$AbstractBuilder.h"

@class $ListBuilder;

NS_ASSUME_NONNULL_BEGIN

@interface $ListBuilder : $AbstractBuilder<$ListBuilder *, UIView *>

@property(nonatomic, readonly) $ListBuilder *(^itemSize)(CGFloat width, CGFloat height);
@property(nonatomic, readonly) $ListBuilder *(^itemSpacing)(CGFloat itemSpacing);
@property(nonatomic, readonly) $ListBuilder *(^lineSpacing)(CGFloat lineSpacing);
@property(nonatomic, readonly) $ListBuilder *(^horizontal)(bool isHorizontal);
@property(nonatomic, readonly) $ListBuilder *(^alwaysBounce)(bool isAlwaysBounce);
@property(nonatomic, readonly) $ListBuilder *(^showIndicator)(bool isShowIndicator);

@property(nonatomic, readonly) UIView *(^children)(NSArray<id> *children);
@property(nonatomic, readonly) UIView *(^forEach)(NSArray *elements, id (^builder)(NSUInteger i, id each));
@property(nonatomic, readonly) UIView *(^build)(NSArray<id> *(^builder)(void));
@property(nonatomic, readonly) UIView *(^count)(NSUInteger count, id (^builder)(NSUInteger i));
@property(nonatomic, readonly) UIView *(^countBy)(NSUInteger (^count)(void), id (^builder)(NSUInteger i));

@end

NS_ASSUME_NONNULL_END

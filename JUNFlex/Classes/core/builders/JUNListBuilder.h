//
//  JUNListBuilder.h
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/30.
//

#import "JUNAbstractBuilder.h"

@class JUNListBuilder;

NS_ASSUME_NONNULL_BEGIN

@interface JUNListBuilder : JUNAbstractBuilder<JUNListBuilder *, UIView *>

@property(nonatomic, readonly) JUNListBuilder *(^itemSize)(CGFloat width, CGFloat height);
@property(nonatomic, readonly) JUNListBuilder *(^itemSpacing)(CGFloat itemSpacing);
@property(nonatomic, readonly) JUNListBuilder *(^lineSpacing)(CGFloat lineSpacing);
@property(nonatomic, readonly) JUNListBuilder *(^horizontal)(bool isHorizontal);
@property(nonatomic, readonly) JUNListBuilder *(^alwaysBounce)(bool isAlwaysBounce);
@property(nonatomic, readonly) JUNListBuilder *(^showIndicator)(bool isShowIndicator);

@property(nonatomic, readonly) UIView *(^children)(NSArray<id> *children);
@property(nonatomic, readonly) UIView *(^forEach)(NSArray *elements, id (^builder)(NSUInteger i, id each));
@property(nonatomic, readonly) UIView *(^build)(NSArray<id> *(^builder)(void));
@property(nonatomic, readonly) UIView *(^count)(NSUInteger count, id (^builder)(NSUInteger i));
@property(nonatomic, readonly) UIView *(^countBy)(NSUInteger (^count)(void), id (^builder)(NSUInteger i));

@end

NS_ASSUME_NONNULL_END

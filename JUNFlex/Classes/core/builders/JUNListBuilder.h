//
//  JUNListBuilder.h
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/30.
//

#import "JUNBaseBuilder.h"

#ifndef itemSize
#define itemSize(width_height, ...) itemSize(width_height, ##__VA_ARGS__, nil)
#endif

@class JUNListBuilder;

NS_ASSUME_NONNULL_BEGIN

@interface JUNListBuilder : JUNBaseBuilder<JUNListBuilder *, __kindof UIView *>

@property(nonatomic, readonly) JUNListBuilder *(^itemSize)(id width_height, ...);
@property(nonatomic, readonly) JUNListBuilder *(^itemSpacing)(id itemSpacing);
@property(nonatomic, readonly) JUNListBuilder *(^lineSpacing)(id lineSpacing);
@property(nonatomic, readonly) JUNListBuilder *(^horizontal)(id isHorizontal);
@property(nonatomic, readonly) JUNListBuilder *(^alwaysBounce)(id isAlwaysBounce);
@property(nonatomic, readonly) JUNListBuilder *(^showIndicator)(id isShowIndicator);

@property(nonatomic, readonly) __kindof UIView *(^children)(NSArray<id> *children);
@property(nonatomic, readonly) __kindof UIView *(^forEach)(NSArray *elements, id (^builder)(NSUInteger i, id each));
@property(nonatomic, readonly) __kindof UIView *(^build)(NSArray<id> *(^builder)(void));
@property(nonatomic, readonly) __kindof UIView *(^count)(NSUInteger count, id (^builder)(NSUInteger i));
@property(nonatomic, readonly) __kindof UIView *(^countBy)(NSUInteger (^count)(void), id (^builder)(NSUInteger i));

@end

NS_ASSUME_NONNULL_END

//
//  JUNPaddingBuilder.h
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/29.
//

#import "JUNBaseBuilder.h"

#ifndef make
    #define make(t_l_b_r, ...) make(t_l_b_r, ##__VA_ARGS__, nil)
#endif

@class JUNPaddingBuilder;

NS_ASSUME_NONNULL_BEGIN

@interface JUNPaddingBuilder : JUNBaseBuilder<JUNPaddingBuilder *, __kindof UIView *>


@property(nonatomic, readonly) JUNPaddingBuilder *(^top)(id top);
@property(nonatomic, readonly) JUNPaddingBuilder *(^left)(id left);
@property(nonatomic, readonly) JUNPaddingBuilder *(^bottom)(id bottom);
@property(nonatomic, readonly) JUNPaddingBuilder *(^right)(id right);
@property(nonatomic, readonly) JUNPaddingBuilder *(^all)(id all);
@property(nonatomic, readonly) JUNPaddingBuilder *(^make)(id t_l_b_r, ...);
/// target can be a uiview or itembuilder
@property(nonatomic, readonly) __kindof UIView *(^child)(id child);

@end

NS_ASSUME_NONNULL_END

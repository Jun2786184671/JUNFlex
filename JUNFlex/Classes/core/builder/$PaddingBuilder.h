//
//  $PaddingBuilder.h
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/29.
//

#import "$AbstractBuilder.h"

@class $PaddingBuilder;

NS_ASSUME_NONNULL_BEGIN

@interface $PaddingBuilder : $AbstractBuilder<$PaddingBuilder *, UIView *>


@property(nonatomic, readonly) $PaddingBuilder *(^top)(CGFloat top);
@property(nonatomic, readonly) $PaddingBuilder *(^left)(CGFloat left);
@property(nonatomic, readonly) $PaddingBuilder *(^bottom)(CGFloat bottom);
@property(nonatomic, readonly) $PaddingBuilder *(^right)(CGFloat right);
@property(nonatomic, readonly) $PaddingBuilder *(^all)(CGFloat all);
@property(nonatomic, readonly) $PaddingBuilder *(^make)(CGFloat t, CGFloat l, CGFloat b, CGFloat r);
/// target can be a uiview or itembuilder
@property(nonatomic, readonly) UIView *(^child)(id child);

@end

NS_ASSUME_NONNULL_END

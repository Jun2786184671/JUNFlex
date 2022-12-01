//
//  JUNInsetWrapper.h
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/29.
//

#import "$ItemBuilder.h"

NS_ASSUME_NONNULL_BEGIN

@interface $PaddingBuilder : $ItemBuilder

@property(nonatomic, readonly) $PaddingBuilder *(^ID)(NSString *identifier);
@property(nonatomic, readonly) $PaddingBuilder *(^color)(UIColor *color);
@property(nonatomic, readonly) $PaddingBuilder *(^radius)(CGFloat radius);
@property(nonatomic, readonly) $PaddingBuilder *(^maskBounds)(bool isMaskBounds);
@property(nonatomic, readonly) $PaddingBuilder *(^alpha)(CGFloat alpha);
@property(nonatomic, readonly) $PaddingBuilder *(^width)(CGFloat width);
@property(nonatomic, readonly) $PaddingBuilder *(^height)(CGFloat height);
@property(nonatomic, readonly) $PaddingBuilder *(^size)(CGSize size);


@property(nonatomic, readonly) $PaddingBuilder *(^top)(CGFloat top);
@property(nonatomic, readonly) $PaddingBuilder *(^left)(CGFloat left);
@property(nonatomic, readonly) $PaddingBuilder *(^bottom)(CGFloat bottom);
@property(nonatomic, readonly) $PaddingBuilder *(^right)(CGFloat right);
@property(nonatomic, readonly) $PaddingBuilder *(^all)(CGFloat all);
@property(nonatomic, readonly) $PaddingBuilder *(^make)(CGFloat t, CGFloat l, CGFloat b, CGFloat r);
/// target can be a uiview or itembuilder
@property(nonatomic, readonly) UIView *(^child)(id item);

@end

NS_ASSUME_NONNULL_END

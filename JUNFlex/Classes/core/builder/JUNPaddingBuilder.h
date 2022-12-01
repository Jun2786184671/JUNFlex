//
//  JUNInsetWrapper.h
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/29.
//

#import "JUNItemBuilder.h"

NS_ASSUME_NONNULL_BEGIN

@interface JUNPaddingBuilder : JUNItemBuilder

@property(nonatomic, readonly) JUNPaddingBuilder *(^ID)(NSString *ID);
@property(nonatomic, readonly) JUNPaddingBuilder *(^color)(UIColor *color);
@property(nonatomic, readonly) JUNPaddingBuilder *(^radius)(CGFloat radius);
@property(nonatomic, readonly) JUNPaddingBuilder *(^maskBounds)(bool isMaskBounds);
@property(nonatomic, readonly) JUNPaddingBuilder *(^alpha)(CGFloat alpha);
@property(nonatomic, readonly) JUNPaddingBuilder *(^width)(CGFloat width);
@property(nonatomic, readonly) JUNPaddingBuilder *(^height)(CGFloat height);
@property(nonatomic, readonly) JUNPaddingBuilder *(^size)(CGSize size);


@property(nonatomic, readonly) JUNPaddingBuilder *(^top)(CGFloat top);
@property(nonatomic, readonly) JUNPaddingBuilder *(^left)(CGFloat left);
@property(nonatomic, readonly) JUNPaddingBuilder *(^bottom)(CGFloat bottom);
@property(nonatomic, readonly) JUNPaddingBuilder *(^right)(CGFloat right);
@property(nonatomic, readonly) JUNPaddingBuilder *(^all)(CGFloat all);
@property(nonatomic, readonly) JUNPaddingBuilder *(^make)(CGFloat t, CGFloat l, CGFloat b, CGFloat r);
/// target can be a uiview or itembuilder
@property(nonatomic, readonly) UIView *(^child)(id item);

@end

NS_ASSUME_NONNULL_END

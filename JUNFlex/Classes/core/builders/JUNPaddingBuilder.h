//
//  JUNPaddingBuilder.h
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/29.
//

#import "JUNAbstractBuilder.h"

@class JUNPaddingBuilder, JUNItem;

NS_ASSUME_NONNULL_BEGIN

@interface JUNPaddingBuilder : JUNAbstractBuilder<JUNPaddingBuilder *, JUNItem *>


@property(nonatomic, readonly) JUNPaddingBuilder *(^top)(CGFloat top);
@property(nonatomic, readonly) JUNPaddingBuilder *(^left)(CGFloat left);
@property(nonatomic, readonly) JUNPaddingBuilder *(^bottom)(CGFloat bottom);
@property(nonatomic, readonly) JUNPaddingBuilder *(^right)(CGFloat right);
@property(nonatomic, readonly) JUNPaddingBuilder *(^all)(CGFloat all);
@property(nonatomic, readonly) JUNPaddingBuilder *(^make)(CGFloat t, CGFloat l, CGFloat b, CGFloat r);
/// target can be a uiview or itembuilder
@property(nonatomic, readonly) JUNItem *(^child)(id child);

@end

NS_ASSUME_NONNULL_END

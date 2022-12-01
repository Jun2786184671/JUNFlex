//
//  JUNFlexBuilder.h
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/27.
//

#import "$ItemBuilder.h"

NS_ASSUME_NONNULL_BEGIN

@interface $StackBuilder : $ItemBuilder

@property(nonatomic, readonly) $StackBuilder *(^ID)(NSString *identifier);
@property(nonatomic, readonly) $StackBuilder *(^color)(UIColor *color);
@property(nonatomic, readonly) $StackBuilder *(^radius)(CGFloat radius);
@property(nonatomic, readonly) $StackBuilder *(^maskBounds)(bool isMaskBounds);
@property(nonatomic, readonly) $StackBuilder *(^alpha)(CGFloat alpha);
@property(nonatomic, readonly) $StackBuilder *(^width)(CGFloat width);
@property(nonatomic, readonly) $StackBuilder *(^height)(CGFloat height);
@property(nonatomic, readonly) $StackBuilder *(^size)(CGSize size);

@property(nonatomic, readonly) $StackBuilder *(^align)(CGPoint);
@property(nonatomic, readonly) UIView *(^children)(NSArray<UIView *> *items);

@end

NS_ASSUME_NONNULL_END

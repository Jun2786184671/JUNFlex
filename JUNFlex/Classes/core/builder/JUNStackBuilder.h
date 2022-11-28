//
//  JUNFlexBuilder.h
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JUNStackBuilder : NSObject

@property(nonatomic, readonly) JUNStackBuilder *(^ID)(NSString *ID);
@property(nonatomic, readonly) JUNStackBuilder *(^color)(UIColor *color);
@property(nonatomic, readonly) JUNStackBuilder *(^radius)(CGFloat radius);
@property(nonatomic, readonly) JUNStackBuilder *(^maskBounds)(bool isMaskBounds);
@property(nonatomic, readonly) JUNStackBuilder *(^alpha)(CGFloat alpha);
@property(nonatomic, readonly) JUNStackBuilder *(^width)(CGFloat width);
@property(nonatomic, readonly) JUNStackBuilder *(^height)(CGFloat height);
@property(nonatomic, readonly) JUNStackBuilder *(^size)(CGSize size);
@property(nonatomic, readonly) JUNStackBuilder *(^align)(CGPoint);
@property(nonatomic, readonly) UIView *(^children)(NSArray<UIView *> *items);

@end

NS_ASSUME_NONNULL_END

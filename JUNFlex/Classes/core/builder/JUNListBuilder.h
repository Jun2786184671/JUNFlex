//
//  JUNListBuilder.h
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JUNListBuilder : NSObject

@property(nonatomic, readonly) JUNListBuilder *(^ID)(NSString *ID);
@property(nonatomic, readonly) JUNListBuilder *(^color)(UIColor *color);
@property(nonatomic, readonly) JUNListBuilder *(^radius)(CGFloat radius);
@property(nonatomic, readonly) JUNListBuilder *(^maskBounds)(bool isMaskBounds);
@property(nonatomic, readonly) JUNListBuilder *(^alpha)(CGFloat alpha);
@property(nonatomic, readonly) JUNListBuilder *(^width)(CGFloat width);
@property(nonatomic, readonly) JUNListBuilder *(^height)(CGFloat height);
@property(nonatomic, readonly) JUNListBuilder *(^size)(CGSize size);
@property(nonatomic, readonly) JUNListBuilder *(^itemSize)(CGSize itemSize);
@property(nonatomic, readonly) JUNListBuilder *(^itemSpacing)(CGFloat itemSpacing);
@property(nonatomic, readonly) JUNListBuilder *(^lineSpacing)(CGFloat lineSpacing);
@property(nonatomic, readonly) JUNListBuilder *(^horizontal)(bool isHorizontal);
@property(nonatomic, readonly) JUNListBuilder *(^alwaysBounce)(bool isAlwaysBounce);
@property(nonatomic, readonly) JUNListBuilder *(^showIndicator)(bool isShowIndicator);

@property(nonatomic, readonly) UIView *(^children)(NSArray<id> *items);
@property(nonatomic, readonly) UIView *(^forEach)(NSArray *elements, id (^builder)(NSUInteger i, id each));
@property(nonatomic, readonly) UIView *(^build)(NSArray<id> *(^builder)(void));
@property(nonatomic, readonly) UIView *(^count)(NSUInteger count, id (^builder)(NSUInteger i));
@property(nonatomic, readonly) UIView *(^countBy)(NSUInteger (^count)(void), id (^builder)(NSUInteger i));

@end

NS_ASSUME_NONNULL_END

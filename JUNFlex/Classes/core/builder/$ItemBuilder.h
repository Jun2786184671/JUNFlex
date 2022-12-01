//
//  JUNWidgetBuilder.h
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/29.
//

#import <Foundation/Foundation.h>

@class JUNItem;

NS_ASSUME_NONNULL_BEGIN

@interface $ItemBuilder : NSObject

@property(nonatomic, readonly) $ItemBuilder *(^ID)(NSString *identifier);
@property(nonatomic, readonly) $ItemBuilder *(^color)(UIColor *color);
@property(nonatomic, readonly) $ItemBuilder *(^alpha)(CGFloat alpha);
@property(nonatomic, readonly) $ItemBuilder *(^text)(NSString *text, CGFloat fontSize, UIColor *color);
@property(nonatomic, readonly) $ItemBuilder *(^radius)(CGFloat radius);
@property(nonatomic, readonly) $ItemBuilder *(^maskBounds)(bool maskBounds);
/// url or name, type NSURL or NSString.
@property(nonatomic, readonly) $ItemBuilder *(^image)(NSString *nameOrURL);
@property(nonatomic, readonly) $ItemBuilder *(^width)(CGFloat width);
@property(nonatomic, readonly) $ItemBuilder *(^height)(CGFloat height);
@property(nonatomic, readonly) $ItemBuilder *(^size)(CGSize size);
@property(nonatomic, readonly) $ItemBuilder *(^onTap)(id target, SEL selector);
/// call when end an item build
@property(nonatomic, readonly) UIView *end;


@end

NS_ASSUME_NONNULL_END

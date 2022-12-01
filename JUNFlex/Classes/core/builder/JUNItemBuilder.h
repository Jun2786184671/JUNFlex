//
//  JUNWidgetBuilder.h
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/29.
//

#import <Foundation/Foundation.h>

@class JUNItem;

NS_ASSUME_NONNULL_BEGIN

@interface JUNItemBuilder : NSObject

@property(nonatomic, readonly) JUNItemBuilder *(^ID)(NSString *ID);
@property(nonatomic, readonly) JUNItemBuilder *(^color)(UIColor *color);
@property(nonatomic, readonly) JUNItemBuilder *(^alpha)(CGFloat a);
@property(nonatomic, readonly) JUNItemBuilder *(^text)(NSString *text, CGFloat fontSize, UIColor *color);
@property(nonatomic, readonly) JUNItemBuilder *(^radius)(CGFloat radius);
@property(nonatomic, readonly) JUNItemBuilder *(^maskBounds)(bool maskBounds);
/// url or name, type NSURL or NSString.
@property(nonatomic, readonly) JUNItemBuilder *(^image)(NSString *nameOrURL);
@property(nonatomic, readonly) JUNItemBuilder *(^width)(CGFloat width);
@property(nonatomic, readonly) JUNItemBuilder *(^height)(CGFloat height);
@property(nonatomic, readonly) JUNItemBuilder *(^size)(CGSize size);
@property(nonatomic, readonly) JUNItemBuilder *(^onTap)(id target, SEL selector);
/// call when end an item build
@property(nonatomic, readonly) UIView *end;


@end

NS_ASSUME_NONNULL_END

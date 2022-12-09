//
//  JUNItemBuilder.h
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/29.
//

#import "JUNAbstractBuilder.h"

@class JUNItemBuilder;

NS_ASSUME_NONNULL_BEGIN

@interface JUNItemBuilder : JUNAbstractBuilder<JUNItemBuilder *, UIView *>

@property(nonatomic, readonly) JUNItemBuilder *(^contentAlign)(UIControlContentHorizontalAlignment horizontal, UIControlContentVerticalAlignment vertical);
@property(nonatomic, readonly) JUNItemBuilder *(^text)(NSString *string, CGFloat fontSize, UIColor *color);
@property(nonatomic, readonly) JUNItemBuilder *(^image)(NSString *nameOrURL);
@property(nonatomic, readonly) JUNItemBuilder *(^onTap)(id target, SEL selector);

@end

NS_ASSUME_NONNULL_END

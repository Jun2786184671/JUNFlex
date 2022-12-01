//
//  JUNWidgetBuilder.h
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/29.
//

#import "$AbstractBuilder.h"

@class $ItemBuilder;

NS_ASSUME_NONNULL_BEGIN

@interface $ItemBuilder : $AbstractBuilder<$ItemBuilder *, UIView *>

@property(nonatomic, readonly) $ItemBuilder *(^text)(NSString *text, CGFloat fontSize, UIColor *color);
@property(nonatomic, readonly) $ItemBuilder *(^image)(NSString *nameOrURL);
@property(nonatomic, readonly) $ItemBuilder *(^onTap)(id target, SEL selector);

@end

NS_ASSUME_NONNULL_END

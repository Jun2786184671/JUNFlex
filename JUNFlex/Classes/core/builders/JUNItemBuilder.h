//
//  JUNItemBuilder.h
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/29.
//

#import "JUNAbstractBuilder.h"

@class JUNItemBuilder, JUNItem;

NS_ASSUME_NONNULL_BEGIN

@interface JUNItemBuilder : JUNAbstractBuilder<JUNItemBuilder *, JUNItem *>

@property(nonatomic, readonly) JUNItemBuilder *(^align)(int main, int cross);
@property(nonatomic, readonly) JUNItemBuilder *(^text)(NSString *string, UIFont *font, UIColor *color);
@property(nonatomic, readonly) JUNItemBuilder *(^image)(NSString *nameOrURL);
@property(nonatomic, readonly) JUNItemBuilder *(^onTap)(id target, SEL selector);

@end

NS_ASSUME_NONNULL_END

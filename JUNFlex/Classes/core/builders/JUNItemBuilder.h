//
//  JUNItemBuilder.h
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/29.
//

#import "JUNBaseBuilder.h"

#ifndef text
    #define text(string, ...) text(string, ##__VA_ARGS__, nil)
#endif

#ifndef align
    #define align(main_cross, ...) align(main_cross, ##__VA_ARGS__, nil)
#endif

@class JUNItemBuilder;

NS_ASSUME_NONNULL_BEGIN

@interface JUNItemBuilder : JUNBaseBuilder<JUNItemBuilder *, __kindof UIView *>

@property(nonatomic, readonly) JUNItemBuilder *(^align)(id main_cross, ...);
/// You can follow the string with UIFont, UIColor, string of color hex, or font size. Note that all parameters must be of object type.
@property(nonatomic, readonly) JUNItemBuilder *(^text)(NSString *string, ...);
@property(nonatomic, readonly) JUNItemBuilder *(^image)(NSString *nameOrURL);
@property(nonatomic, readonly) JUNItemBuilder *(^action)(id target, SEL selector);

@end

NS_ASSUME_NONNULL_END

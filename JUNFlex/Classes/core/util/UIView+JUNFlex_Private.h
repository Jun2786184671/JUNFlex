//
//  UIView+JUNex4Flex.h
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/28.
//

#import <UIKit/UIKit.h>
#import "JUNBaseProperty.h"

#define JUN_REGISTER_CLASS(jsonClsName, propertyCls) \
+ (void)load {\
    [super load];\
}\
+ (NSString *)jun_getJsonClassName {\
    return jsonClsName;\
}\
+ (Class)jun_getPropertyClass {\
    return propertyCls;\
}

NS_ASSUME_NONNULL_BEGIN

@interface UIView (JUNFlex_Private)

- (CGRect)jun_validateFrame;

- (void)jun_setWidth:(CGFloat)width;
- (void)jun_setHeight:(CGFloat)height;

+ (NSString *)jun_getJsonClassName;
+ (Class)jun_getPropertyClass;

@property(nonatomic, strong, nullable, setter=jun_setProperty:) __kindof JUNBaseProperty *jun_property;
- (instancetype)initWithJUNProperty:(__kindof JUNBaseProperty *)property;

@end

NS_ASSUME_NONNULL_END

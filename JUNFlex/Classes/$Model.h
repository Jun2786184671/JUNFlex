//
//  JUNContent.h
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface $Model : NSObject

/// $ is json from server
@property(class, nonatomic, readonly) void (^$Mapper)(void (^mapper)(id $, __kindof $Model *_));

@property(nonatomic, readonly) __kindof $Model *(^$map)(id json);
@property(class, nonatomic, readonly) __kindof $Model *(^$map)(id json);

@property(class, nonatomic, readonly) void (^$Layout)(id (^builder)(__kindof $Model *_));
@property(nonatomic, readonly) __kindof UIView *$render;

@end

NS_ASSUME_NONNULL_END

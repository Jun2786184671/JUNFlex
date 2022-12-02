//
//  NSObject+$Model.h
//  JUNFlex
//
//  Created by Jun Ma on 2022/12/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject ($Model)

/// $ is json from server
@property(class, nonatomic, readonly) void (^$mapper)(void (^mapper)(id $, __kindof NSObject *_));

@property(nonatomic, readonly) __kindof NSObject *(^$map)(id json);
@property(class, nonatomic, readonly) __kindof NSObject *(^$map)(id json);

@property(class, nonatomic, readonly) void (^$layout)(id (^builder)(__kindof NSObject *_));
@property(nonatomic, readonly) __kindof UIView *$render;

@end

NS_ASSUME_NONNULL_END

//
//  JUNContent.h
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JUNModel : NSObject

/// $ is json from server
@property(class, nonatomic, readonly) void (^mapper)(void (^mapper)(id $, __kindof JUNModel *_));

@property(nonatomic, readonly) __kindof JUNModel *(^map)(id json);
@property(class, nonatomic, readonly) __kindof JUNModel *(^map)(id json);

@property(class, nonatomic, readonly) void (^layout)(id (^builder)(__kindof JUNModel *_));
@property(nonatomic, readonly) __kindof UIView *render;

@end

NS_ASSUME_NONNULL_END

//
//  JUNNativeBuilder.h
//  JUNFlex
//
//  Created by Jun Ma on 2022/12/12.
//

#import "JUNBaseBuilder.h"

@class JUNPropertyBuilder;

NS_ASSUME_NONNULL_BEGIN

@interface JUNPropertyBuilder : JUNBaseBuilder<JUNPropertyBuilder *, __kindof UIView *>

- (instancetype)initWithTarget:(__kindof UIView *)target;

@end

NS_ASSUME_NONNULL_END

//
//  JUNNativeBuilder.h
//  JUNFlex
//
//  Created by Jun Ma on 2022/12/12.
//

#import "JUNAbstractBuilder.h"

@class JUNPropertyBuilder;

NS_ASSUME_NONNULL_BEGIN

@interface JUNPropertyBuilder : JUNAbstractBuilder<JUNPropertyBuilder *, __kindof UIView *>

- (instancetype)initWithTarget:(__kindof UIView *)target;

@end

NS_ASSUME_NONNULL_END

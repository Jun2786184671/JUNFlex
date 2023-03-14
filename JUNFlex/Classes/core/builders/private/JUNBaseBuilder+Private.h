//
//  JUNAbstractBuilder+Private.h
//  JUNFlex
//
//  Created by Jun Ma on 2022/12/1.
//

#import "JUNBaseBuilder.h"
#import "JUNBaseProperty.h"

NS_ASSUME_NONNULL_BEGIN

@interface JUNBaseBuilder<__covariant ClassType, __covariant ProductType> ()

@property(nonatomic, strong, readonly) __kindof UIView *product;
@property(nonatomic, strong, readonly) __kindof JUNBaseProperty *property;

@end

NS_ASSUME_NONNULL_END

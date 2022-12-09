//
//  JUNAbstractBuilder+Private.h
//  JUNFlex
//
//  Created by Jun Ma on 2022/12/1.
//

#import "JUNAbstractBuilder.h"

NS_ASSUME_NONNULL_BEGIN

@interface JUNAbstractBuilder<__covariant ClassType, __covariant ProductType> ()

/// serialize identifier in json
@property(class, nonatomic, readonly) NSString *type;

@property(nonatomic, strong, readonly) ProductType product;

- (NSString *)_stringFromValue:(id)value;
- (int)_intFromValue:(id)value;
- (CGFloat)_floatFromValue:(id)value;
- (bool)_boolFromValue:(id)value;
- (UIColor *)_colorFromValue:(id)value;

@end

NS_ASSUME_NONNULL_END

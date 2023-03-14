//
//  JUNPaddingProperty.h
//  JUNFlex
//
//  Created by Jun Ma on 2023/3/8.
//

#import "JUNBaseProperty.h"

NS_ASSUME_NONNULL_BEGIN

@interface JUNPaddingProperty : JUNBaseProperty

@property(nonatomic, strong, nullable) NSNumber *top;
@property(nonatomic, strong, nullable) NSNumber *left;
@property(nonatomic, strong, nullable) NSNumber *bottom;
@property(nonatomic, strong, nullable) NSNumber *right;
@property(nonatomic, strong, nullable) __kindof JUNBaseProperty *childProperty;
@property(nonatomic, strong, nullable) __kindof UIView *childView;

@end

NS_ASSUME_NONNULL_END

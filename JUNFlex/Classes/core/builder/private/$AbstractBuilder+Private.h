//
//  $AbstractBuilder+Private.h
//  JUNFlex
//
//  Created by Jun Ma on 2022/12/1.
//

#import "$AbstractBuilder.h"

NS_ASSUME_NONNULL_BEGIN

@interface $AbstractBuilder<__covariant ClassType, __covariant ProductType> ()

@property(nonatomic, strong, readonly) ProductType product;

@end

NS_ASSUME_NONNULL_END

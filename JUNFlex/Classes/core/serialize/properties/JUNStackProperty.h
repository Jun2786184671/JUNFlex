//
//  JUNStackProperty.h
//  JUNFlex
//
//  Created by Jun Ma on 2023/3/7.
//

#import "JUNBaseProperty.h"
#import "JUNAlignProperty.h"

NS_ASSUME_NONNULL_BEGIN

@interface JUNStackProperty : JUNBaseProperty

@property(nonatomic, strong, nullable) JUNAlignProperty *align;
@property(nonatomic, strong, nullable) NSNumber *aspectRatio;
@property(nonatomic, strong, nullable) NSArray<__kindof JUNBaseProperty *> *childrenProperties;
@property(nonatomic, strong, nullable) NSArray<__kindof UIView *> *childrenViews;

@end

NS_ASSUME_NONNULL_END

//
//  JUNListProperty.h
//  JUNFlex
//
//  Created by Jun Ma on 2023/3/8.
//

#import "JUNBaseProperty.h"

NS_ASSUME_NONNULL_BEGIN

@interface JUNListProperty : JUNBaseProperty

@property(nonatomic, strong, nullable) JUNSizeProperty *itemSize;
@property(nonatomic, strong, nullable) NSNumber *itemSpacing;
@property(nonatomic, strong, nullable) NSNumber *lineSpacing;
@property(nonatomic, strong, nullable) NSNumber *horizontal;
@property(nonatomic, strong, nullable) NSNumber *alwaysBounce;
@property(nonatomic, strong, nullable) NSNumber *showIndicator;
@property(nonatomic, strong, nullable) NSArray<__kindof JUNBaseProperty *> *childrenProperties;
@property(nonatomic, strong, nullable) NSArray<__kindof UIView *> *childrenViews;

@end

NS_ASSUME_NONNULL_END

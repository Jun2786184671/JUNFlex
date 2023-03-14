//
//  UIColor+JUNFlex_Private.h
//  JUNFlex
//
//  Created by Jun Ma on 2023/3/7.
//

#import <UIKit/UIKit.h>
#import "JUNColorProperty.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (JUNFlex_Private)

+ (instancetype)jun_colorWithHexString:(NSString *)hexString;
+ (instancetype)jun_colorWithProperty:(JUNColorProperty *)property;

@end

NS_ASSUME_NONNULL_END

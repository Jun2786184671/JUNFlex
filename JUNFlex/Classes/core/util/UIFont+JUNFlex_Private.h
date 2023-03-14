//
//  UIFont+JUNFlex_Private.h
//  JUNFlex
//
//  Created by Jun Ma on 2022/12/12.
//

#import <UIKit/UIKit.h>
#import "JUNFontProperty.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIFont (JUNFlex_Private)

+ (instancetype)jun_fontWithProperty:(JUNFontProperty *)property;

@end

NS_ASSUME_NONNULL_END

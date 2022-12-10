//
//  UIColor+JUNex4Flex.h
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/29.
//

#import <UIKit/UIKit.h>

#ifndef JUNColorHex
#define JUNColorHex(RGBa) [UIColor jun_colorWithRGBa:RGBa]
#endif

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (JUNFlex)

+ (UIColor *)jun_colorWithRGBa:(uint32_t)RGBa;

@end

NS_ASSUME_NONNULL_END

//
//  UIColor+JUNex4Flex.m
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/29.
//

#import "UIColor+JUNFlex.h"

@implementation UIColor (JUNFlex)

+ (UIColor *)jun_colorWithRGBa:(uint32_t)RGBa {
    uint8_t r = ((RGBa & 0xFF000000) >> 24);
    uint8_t g = ((RGBa & 0x00FF0000) >> 16);
    uint8_t b = ((RGBa & 0x0000FF00) >> 8);
    uint8_t a = ((RGBa & 0x000000FF) >> 0);
    a = a ? a : 0xFF;
    return [UIColor colorWithRed:((float)r / 255.0) green:((float)g / 255.0) blue:((float)b / 255.0) alpha:((float)a / 255.0)];
}

@end

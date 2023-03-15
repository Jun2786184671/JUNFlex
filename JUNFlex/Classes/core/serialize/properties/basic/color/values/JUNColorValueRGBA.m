//
//  JUNColorRGBAValue.m
//  JUNFlex
//
//  Created by Jun Ma on 2023/3/12.
//

#import "JUNColorValueRGBA.h"
#import <MJExtension/NSObject+MJKeyValue.h>

static NSString * const kJUNColorValueRGBAHex = @"hex";

@implementation JUNColorValueRGBA

+ (NSArray *)mj_allowedPropertyNames {
    return @[
        NSStringFromSelector(@selector(a)),
    ];
}

- (void)mj_objectDidConvertToKeyValues:(NSMutableDictionary *)keyValues {
    [super mj_objectDidConvertToKeyValues:keyValues];
    uint32_t hex = ((((self.r << 8) | self.g) << 8) | self.b);
    keyValues[kJUNColorValueRGBAHex] = [NSString stringWithFormat:@"#%06x", hex];
}

- (void)mj_didConvertToObjectWithKeyValues:(NSDictionary *)keyValues {
    [super mj_didConvertToObjectWithKeyValues:keyValues];
    NSString *hexStr = keyValues[kJUNColorValueRGBAHex];
    NSScanner *scanner = [NSScanner scannerWithString:[hexStr substringFromIndex:1]];
    uint32_t hex;
    [scanner scanHexInt:&hex];
    self.r = (hex & 0xff0000) >> 16;
    self.g = (hex & 0x00ff00) >> 8;
    self.b = hex & 0x0000ff;
}

@end

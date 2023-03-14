//
//  JUNBuildParser.h
//  JUNFlex
//
//  Created by Jun Ma on 2023/3/12.
//

#import <Foundation/Foundation.h>
#import "JUNColorProperty.h"
#import "JUNFontProperty.h"

NS_ASSUME_NONNULL_BEGIN

@interface JUNPropertyParser : NSObject

+ (instancetype)sharedParser;

- (BOOL)isStringColorHexString:(NSString *)string;
- (JUNColorProperty * _Nullable)parseColorPropertyWithValue:(id)value;
- (JUNFontProperty * _Nullable)parseFontPropertyWithValue:(id)value;
- (NSNumber * _Nullable)parseFloatWithValue:(id)value;
- (NSNumber * _Nullable)parseBoolWithValue:(id)value;

@end

NS_ASSUME_NONNULL_END

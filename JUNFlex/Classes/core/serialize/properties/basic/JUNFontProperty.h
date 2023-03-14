//
//  JUNFontProperties.h
//  JUNFlexTool
//
//  Created by Jun Ma on 2022/12/10.
//

#import "JUNProperty.h"
#import "JUNSizeProperty.h"

NS_ASSUME_NONNULL_BEGIN

@interface JUNFontProperty : JUNProperty

@property(nonatomic, copy, nullable) NSString *family;
@property(nonatomic, copy, nullable) NSString *name;
@property(nonatomic, strong, nullable) NSNumber *size;

- (instancetype)initWithFont:(UIFont *)font;
- (instancetype)initWithFontSize:(CGFloat)fontSize;
@property(nonatomic, readonly, nullable) UIFont *font;

@end

NS_ASSUME_NONNULL_END

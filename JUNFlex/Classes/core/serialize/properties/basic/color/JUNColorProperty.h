//
//  JUNColorProperty.h
//  JUNFlex
//
//  Created by Jun Ma on 2023/3/12.
//

#import "JUNProperty.h"
#import "JUNColorValue.h"

typedef NSString * JUNColorSpace;

NS_ASSUME_NONNULL_BEGIN

extern JUNColorSpace const JUNColorSpaceRGBA;
extern JUNColorSpace const JUNColorSpaceHSBA;
extern JUNColorSpace const JUNColorSpaceWA;

@interface JUNColorProperty : JUNProperty

@property(nonatomic, copy) JUNColorSpace space;
@property(nonatomic, strong) __kindof JUNColorValue *value;

- (instancetype)initWithColor:(UIColor *)color;
@property(nonatomic, readonly, nullable) UIColor *color;

@end

NS_ASSUME_NONNULL_END

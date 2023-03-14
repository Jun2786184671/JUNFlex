//
//  JUNTextProperties.h
//  JUNFlexTool
//
//  Created by Jun Ma on 2022/12/10.
//

#import "JUNProperty.h"
#import "JUNFontProperty.h"
#import "JUNColorProperty.h"

NS_ASSUME_NONNULL_BEGIN

@interface JUNTextProperty : JUNProperty

@property(nonatomic, copy) NSString *string;
@property(nonatomic, strong, nullable) JUNColorProperty *color;
@property(nonatomic, strong, nullable) JUNFontProperty *font;

@end

NS_ASSUME_NONNULL_END

//
//  JTSizeProperties.h
//  JUNFlexTool
//
//  Created by Jun Ma on 2022/12/11.
//

#import "JUNProperty.h"

NS_ASSUME_NONNULL_BEGIN

extern NSString * const JUNSizePropertyMax;
extern NSString * const JUNSizePropertyMin;

@interface JUNSizeProperty : JUNProperty

@property(nonatomic, strong, nullable) NSNumber *width;
@property(nonatomic, strong, nullable) NSNumber *height;

@end

NS_ASSUME_NONNULL_END

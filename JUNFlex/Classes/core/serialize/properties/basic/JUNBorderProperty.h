//
//  JTBorderProperty.h
//  JUNFlexTool
//
//  Created by Jun Ma on 2022/12/11.
//

#import "JUNProperty.h"
#import "JUNColorProperty.h"

NS_ASSUME_NONNULL_BEGIN

@interface JUNBorderProperty : JUNProperty

@property(nonatomic, strong, nullable) NSNumber *width;
@property(nonatomic, strong, nullable) JUNColorProperty *color;

@end

NS_ASSUME_NONNULL_END

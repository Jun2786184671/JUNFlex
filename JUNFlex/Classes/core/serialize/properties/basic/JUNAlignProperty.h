//
//  JUNAlignProperties.h
//  JUNFlexTool
//
//  Created by Jun Ma on 2022/12/10.
//

#import "JUNProperty.h"

NS_ASSUME_NONNULL_BEGIN

@interface JUNAlignProperty : JUNProperty

@property(nonatomic, strong, nullable) NSNumber *main;
@property(nonatomic, strong, nullable) NSNumber *cross;

@end

NS_ASSUME_NONNULL_END

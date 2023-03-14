//
//  JUNItemProperties.h
//  JUNFlexTool
//
//  Created by Jun Ma on 2022/12/10.
//

#import "JUNBaseProperty.h"
#import "JUNAlignProperty.h"
#import "JUNTextProperty.h"
#import "JUNActionProperty.h"

NS_ASSUME_NONNULL_BEGIN

@interface JUNItemProperty : JUNBaseProperty

@property(nonatomic, strong, nullable) JUNAlignProperty *align;
@property(nonatomic, strong, nullable) JUNTextProperty *text;
@property(nonatomic, copy, nullable) NSString *image;
@property(nonatomic, strong, nullable) JUNActionProperty *action;

@end

NS_ASSUME_NONNULL_END

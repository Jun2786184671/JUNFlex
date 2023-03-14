//
//  JUNBaseProperties.h
//  JUNFlexTool
//
//  Created by Jun Ma on 2022/12/10.
//

#import "JUNProperty.h"
#import "JUNBorderProperty.h"
#import "JUNSizeProperty.h"
#import "JUNColorProperty.h"

NS_ASSUME_NONNULL_BEGIN

extern NSString * const kJUNBasePropertyJsonClassName;
extern NSString * const kJUNBasePropertyID;

@interface JUNBaseProperty : JUNProperty

@property(nonatomic, copy) NSString *jsonClassName;
@property(nonatomic, copy, nullable) NSString *ID;
@property(nonatomic, strong, nullable) id data;
@property(nonatomic, strong, nullable) NSNumber *alpha;
@property(nonatomic, strong, nullable) NSNumber *radius;
@property(nonatomic, strong, nullable) NSNumber *maskBounds;
@property(nonatomic, strong, nullable) JUNSizeProperty *size;
@property(nonatomic, strong, nullable) JUNColorProperty *color;
@property(nonatomic, strong, nullable) JUNBorderProperty *border;

@end

NS_ASSUME_NONNULL_END

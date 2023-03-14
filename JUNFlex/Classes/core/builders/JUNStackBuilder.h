//
//  JUNStackBuilder.h
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/27.
//

#import "JUNBaseBuilder.h"

@class JUNStackBuilder;

NS_ASSUME_NONNULL_BEGIN

@interface JUNStackBuilder : JUNBaseBuilder<JUNStackBuilder *, __kindof UIView *>

@property(nonatomic, readonly) JUNStackBuilder *(^align)(id main, id cross);
/// Aspect ratio when items over crowding, default false. When you use CGFLOAT_MAX to expand an item, do not set it true.
@property(nonatomic, readonly) JUNStackBuilder *(^aspectRatio)(id aspectRatio);
@property(nonatomic, readonly) __kindof UIView *(^children)(NSArray<id> *children);

@end

NS_ASSUME_NONNULL_END

//
//  JUNStackBuilder.h
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/27.
//

#import "JUNItemBuilder.h"

@class JUNStackBuilder, JUNItem;

NS_ASSUME_NONNULL_BEGIN

@interface JUNStackBuilder : JUNAbstractBuilder<JUNStackBuilder *, JUNItem *>

@property(nonatomic, readonly) JUNStackBuilder *(^align)(int main, int cross);
/// Aspect ratio when items over crowding, default false. When you use CGFLOAT_MAX to expand an item, do not set it true.
@property(nonatomic, readonly) JUNStackBuilder *(^aspectRatio)(bool aspectRatio);
@property(nonatomic, readonly) JUNItem *(^children)(NSArray<id> *children);

@end

NS_ASSUME_NONNULL_END

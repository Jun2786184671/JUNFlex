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
@property(nonatomic, readonly) JUNItem *(^children)(NSArray<id> *children);

@end

NS_ASSUME_NONNULL_END

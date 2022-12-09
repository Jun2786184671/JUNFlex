//
//  JUNStackBuilder.h
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/27.
//

#import "JUNItemBuilder.h"

@class JUNStackBuilder;

NS_ASSUME_NONNULL_BEGIN

@interface JUNStackBuilder : JUNAbstractBuilder<JUNStackBuilder *, UIView *>

@property(nonatomic, readonly) JUNStackBuilder *(^align)(int main, int cross);
@property(nonatomic, readonly) UIView *(^children)(NSArray<id> *children);

@end

NS_ASSUME_NONNULL_END

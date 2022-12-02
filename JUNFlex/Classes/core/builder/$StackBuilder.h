//
//  $StackBuilder.h
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/27.
//

#import "$ItemBuilder.h"

@class $StackBuilder;

NS_ASSUME_NONNULL_BEGIN

@interface $StackBuilder : $AbstractBuilder<$StackBuilder *, UIView *>

@property(nonatomic, readonly) $StackBuilder *(^align)(CGPoint align);
@property(nonatomic, readonly) UIView *(^children)(NSArray<id> *children);

@end

NS_ASSUME_NONNULL_END

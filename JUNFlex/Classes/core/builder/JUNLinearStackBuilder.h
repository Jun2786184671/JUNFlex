//
//  JUNLinearStackBuilder.h
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/27.
//

#import "JUNStackBuilder.h"
#import "JUNStackBuilder+JUNex.h"

NS_ASSUME_NONNULL_BEGIN

@interface JUNLinearStackBuilder : JUNStackBuilder

- (JUNStack *)_getStackWithItems:(NSArray<UIView *> *)items alignment:(JUNFlexAlignment)alignment arrangement:(JUNFlexLinearArrangement)arrangement insets:(UIEdgeInsets)insets;

@end

NS_ASSUME_NONNULL_END

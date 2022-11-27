//
//  JUNFlex.h
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/26.
//

#import "JUNStack.h"

NS_ASSUME_NONNULL_BEGIN

@interface JUNLinearStack : JUNStack

- (instancetype)initWithItems:(NSArray<UIView *> *)items alignment:(JUNFlexAlignment)alignment arrangement:(JUNFlexLinearArrangement)arrangement insets:(UIEdgeInsets)insets;
@property(nonatomic, assign, readonly) JUNFlexLinearArrangement arrangement;

- (void)_setUpConstraintsForItem:(nullable UIView *)item andSizeBox:(UIView *)sizeBox prevItem:(nullable UIView *)prevItem prevSizeBox:(nullable UIView *)prevSizeBox;

@end

NS_ASSUME_NONNULL_END

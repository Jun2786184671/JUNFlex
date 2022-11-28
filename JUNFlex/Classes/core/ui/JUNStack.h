//
//  JUNStack.h
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/27.
//

#import <UIKit/UIKit.h>
#import "JUNStackMeta.h"

NS_ASSUME_NONNULL_BEGIN

@interface JUNStack : UIView

- (instancetype)initWithItems:(NSArray<UIView *> *)items alignment:(JUNStackAlignment)alignment insets:(UIEdgeInsets)insets;

@property(nonatomic, strong, readonly) NSArray<UIView *> *items;
@property(nonatomic, assign, readonly) JUNStackAlignment alignment;
@property(nonatomic, assign, readonly) UIEdgeInsets insets;

@end

NS_ASSUME_NONNULL_END

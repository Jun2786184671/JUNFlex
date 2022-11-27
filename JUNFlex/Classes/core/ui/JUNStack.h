//
//  JUNStack.h
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/27.
//

#import <UIKit/UIKit.h>
#import "JUNFlex.h"

NS_ASSUME_NONNULL_BEGIN

@interface JUNStack : UIView

- (instancetype)initWithItems:(NSArray<UIView *> *)items alignment:(JUNFlexAlignment)alignment insets:(UIEdgeInsets)insets;
@property(nonatomic, strong, readonly) NSArray<UIView *> *items;
@property(nonatomic, assign, readonly) JUNFlexAlignment alignment;
@property(nonatomic, assign, readonly) UIEdgeInsets insets;

@property(nonatomic, assign, readonly) JUNFlexDirection direction;

@end

NS_ASSUME_NONNULL_END

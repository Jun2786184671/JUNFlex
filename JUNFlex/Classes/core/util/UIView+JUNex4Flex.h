//
//  UIView+JUNex4Flex.h
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (JUNex4Flex)

- (CGRect)jun_validateFrame;
- (void)jun_addDefaultConstraintsIfNeeded;
- (UIView *)jun_wrapWithInset:(UIEdgeInsets)insets;

@end

NS_ASSUME_NONNULL_END

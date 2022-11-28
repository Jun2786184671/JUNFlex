//
//  JUNStack.h
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/27.
//

#import <UIKit/UIKit.h>

typedef enum {
    JUNStackAlignmentCrossAxisMax = 1 << 0,
    JUNStackAlignmentCrossAxisCenter = 1 << 1,
    JUNStackAlignmentCrossAxisMin = 1 << 2,
    JUNStackAlignmentMainAxisMax = 1 << 3,
    JUNStackAlignmentMainAxisCenter = 1 << 4,
    JUNStackAlignmentMainAxisMin = 1 << 5,
} JUNStackAlignment;

NS_ASSUME_NONNULL_BEGIN

@interface JUNStack : UIView

- (instancetype)initWithItems:(NSArray<UIView *> *)items alignment:(JUNStackAlignment)alignment insets:(UIEdgeInsets)insets;

@property(nonatomic, strong, readonly) NSArray<UIView *> *items;
@property(nonatomic, assign, readonly) JUNStackAlignment alignment;
@property(nonatomic, assign, readonly) UIEdgeInsets insets;

@end

NS_ASSUME_NONNULL_END

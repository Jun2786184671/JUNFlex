//
//  JUNStackMeta.h
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/28.
//

typedef enum {
    JUNStackAlignmentMainAxisMin = 1 << 0,
    JUNStackAlignmentMainAxisCenter = 1 << 1,
    JUNStackAlignmentMainAxisMax = 1 << 2,
    JUNStackAlignmentCrossAxisMin = 1 << 3,
    JUNStackAlignmentCrossAxisCenter = 1 << 4,
    JUNStackAlignmentCrossAxisMax = 1 << 5,
} JUNStackAlignment;

NS_ASSUME_NONNULL_BEGIN

extern NSString * const kJUNStackAlignment;
extern NSString * const kJUNStackInsets;

NS_ASSUME_NONNULL_END

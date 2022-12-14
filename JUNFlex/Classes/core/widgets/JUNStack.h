//
//  JUNStack.h
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/27.
//

#import "JUNItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface JUNStack : JUNItem

- (instancetype)initWithItems:(NSArray<UIView *> *)items mainAxisAlignment:(int)mainAxisAlignment crossAxisAlignment:(int)crossAxisAlignment aspectRatio:(bool)aspectRatio;

@property(nonatomic, strong, readonly) NSArray<UIView *> *items;
@property(nonatomic, assign, readonly) int mainAxisAlignment;
@property(nonatomic, assign, readonly) int crossAxisAlignment;
@property(nonatomic, assign, readonly, getter=isAspectRatio) bool aspectRatio;

@end

NS_ASSUME_NONNULL_END

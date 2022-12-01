//
//  JUNStack.h
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/27.
//

#import "JUNItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface JUNStack : JUNItem

- (instancetype)initWithItems:(NSArray<UIView *> *)items alignment:(CGPoint)alignment;

@property(nonatomic, strong, readonly) NSArray<UIView *> *items;
@property(nonatomic, assign, readonly) CGPoint alignment;

@end

NS_ASSUME_NONNULL_END

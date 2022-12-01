//
//  JUNStackBuilder+Private.h
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/27.
//

#import "$StackBuilder.h"
#import "JUNStack.h"

NS_ASSUME_NONNULL_BEGIN

@interface $StackBuilder ()

- (JUNStack *)_getStackWithItems:(NSArray<UIView *> *)items alignment:(CGPoint)alignment;

@end

NS_ASSUME_NONNULL_END

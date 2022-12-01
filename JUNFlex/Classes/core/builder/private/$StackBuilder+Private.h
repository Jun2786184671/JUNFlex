//
//  $StackBuilder+Private.h
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/27.
//

#import "$StackBuilder.h"
#import "$Stack.h"

NS_ASSUME_NONNULL_BEGIN

@interface $StackBuilder ()

- ($Stack *)_getProductWithChildren:(NSArray<UIView *> *)items alignment:(CGPoint)alignment;

@end

NS_ASSUME_NONNULL_END

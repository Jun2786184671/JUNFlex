//
//  JUNStackBuilder+Private.h
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/27.
//

#import "JUNStackBuilder.h"
#import "JUNStack.h"

NS_ASSUME_NONNULL_BEGIN

@interface JUNStackBuilder ()

- (JUNStack *)_getProductWithChildren:(NSArray<UIView *> *)items  mainAxisAlignment:(int)mainAxisAlignment crossAxisAlignment:(int)crossAxisAlignment aspectRatio:(bool)aspectRatio;

@end

NS_ASSUME_NONNULL_END

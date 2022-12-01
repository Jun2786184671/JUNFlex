//
//  JUNFlex.h
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/26.
//

#import "$Stack.h"

NS_ASSUME_NONNULL_BEGIN

@interface $LinearStack : $Stack

@property(nonatomic, assign, readonly, getter=isHorizontal) bool horizontal;

@end

NS_ASSUME_NONNULL_END

//
//  JUNActionProperty.h
//  JUNFlex
//
//  Created by Jun Ma on 2022/12/12.
//

#import "JUNProperty.h"

NS_ASSUME_NONNULL_BEGIN

@interface JUNActionProperty : JUNProperty

@property(nonatomic, strong) id target;
@property(nonatomic, copy) NSString *selector;

@end

NS_ASSUME_NONNULL_END

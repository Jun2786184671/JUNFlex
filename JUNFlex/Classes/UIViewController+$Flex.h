//
//  UIViewController+$Flex.h
//  JUNFlex
//
//  Created by Jun Ma on 2022/12/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController ($Flex)

@property(nonatomic, readonly) void (^layout)(NSString *fileName);

@end

NS_ASSUME_NONNULL_END

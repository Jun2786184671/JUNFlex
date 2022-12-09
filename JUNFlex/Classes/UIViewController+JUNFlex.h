//
//  UIViewController+JUNFlex.h
//  JUNFlex
//
//  Created by Jun Ma on 2022/12/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (JUNFlex)

@property(nonatomic, readonly) void (^jun_layout)(NSString *fileName);

@end

NS_ASSUME_NONNULL_END

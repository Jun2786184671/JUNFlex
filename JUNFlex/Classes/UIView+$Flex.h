//
//  UIView+$Flex.h
//  JUNFlex
//
//  Created by Jun Ma on 2022/12/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView ($Flex)

@property(nonatomic, readonly) void (^$ID)(NSString *identifier);
@property(nonatomic, readonly) NSArray<UIView *> * _Nullable (^$query)(NSString *identifier);
@property(nonatomic, readonly) UIView * _Nullable (^$query0)(NSString *identifier);

@end

NS_ASSUME_NONNULL_END

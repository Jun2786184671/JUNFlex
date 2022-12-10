//
//  UIView+JUNFlex.h
//  JUNFlex
//
//  Created by Jun Ma on 2022/12/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (JUNFlex)

@property(nonatomic, readonly) void (^jun_ID)(NSString *identifier);
@property(nonatomic, readonly) NSArray<UIView *> * _Nullable (^jun_query)(NSString *identifier);
@property(nonatomic, readonly) UIView * _Nullable (^jun_query0)(NSString *identifier);
@property(nonatomic, readonly) void (^jun_layout)(NSString *fileName);

@property(nonatomic, strong, readonly, nullable) id jun_data;

@end

NS_ASSUME_NONNULL_END

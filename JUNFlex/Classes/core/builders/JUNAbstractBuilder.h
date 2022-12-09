//
//  JUNAbstractBuilder.h
//  JUNFlex
//
//  Created by Jun Ma on 2022/12/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JUNAbstractBuilder<__covariant ClassType, __covariant ProductType> : NSObject

@property(nonatomic, readonly) ClassType (^ID)(NSString *identifier);
@property(nonatomic, readonly) ClassType (^data)(id data);
@property(nonatomic, readonly) ClassType (^color)(UIColor *color);
@property(nonatomic, readonly) ClassType (^alpha)(CGFloat alpha);

@property(nonatomic, readonly) ClassType (^radius)(CGFloat radius);
@property(nonatomic, readonly) ClassType (^border)(CGFloat width, UIColor *color);
@property(nonatomic, readonly) ClassType (^maskBounds)(bool maskBounds);

@property(nonatomic, readonly) ClassType (^width)(CGFloat width);
@property(nonatomic, readonly) ClassType (^height)(CGFloat height);
@property(nonatomic, readonly) ClassType (^size)(CGFloat width, CGFloat height);

/// Call this when end of build. (optional when wrapped by other builders)
@property(nonatomic, readonly) ProductType EOB;

- (UIView *)buildWithDictionary:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END


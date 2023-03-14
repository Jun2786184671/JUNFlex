//
//  JUNAbstractBuilder.h
//  JUNFlex
//
//  Created by Jun Ma on 2022/12/1.
//

#import <UIKit/UIKit.h>

#ifndef border
#define border(width_color, ...) border(width_color, ##__VA_ARGS__, nil)
#endif

#ifndef size
#define size(width_height, ...) size(width_height, ##__VA_ARGS__, nil)
#endif

NS_ASSUME_NONNULL_BEGIN

@interface JUNBaseBuilder<__covariant ClassType, __covariant ProductType> : NSObject

@property(nonatomic, readonly) ClassType (^ID)(id identifier);
@property(nonatomic, readonly) ClassType (^data)(id data);
/// You can pass a UIColor or hex string to specify the color.
@property(nonatomic, readonly) ClassType (^color)(id color);
@property(nonatomic, readonly) ClassType (^alpha)(id alpha);

@property(nonatomic, readonly) ClassType (^radius)(id radius);
/// You can pass a UIColor or hex string to specify the color, and a number of object type to specify the border width.
@property(nonatomic, readonly) ClassType (^border)(id width_color, ...);
@property(nonatomic, readonly) ClassType (^maskBounds)(id maskBounds);

@property(nonatomic, readonly) ClassType (^width)(id width);
@property(nonatomic, readonly) ClassType (^height)(id height);
@property(nonatomic, readonly) ClassType (^size)(id width_height, ...);

/// Call this when end of build. (optional when wrapped by other builders)
@property(nonatomic, readonly) ProductType EOB;

@end

NS_ASSUME_NONNULL_END


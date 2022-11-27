//
//  JUNFlexBuilder.h
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JUNStackBuilder : NSObject

+ (instancetype)sharedInstance;
@property(nonatomic, readonly) JUNStackBuilder *(^properties)(NSDictionary * _Nullable configurations);
@property(nonatomic, readonly) UIView *(^children)(NSArray<UIView *> *items);

@end

NS_ASSUME_NONNULL_END

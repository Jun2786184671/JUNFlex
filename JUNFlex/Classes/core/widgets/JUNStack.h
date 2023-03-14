//
//  JUNStack.h
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/27.
//

#import "JUNBaseView.h"
#import "JUNStackProperty.h"

NS_ASSUME_NONNULL_BEGIN

@interface JUNStack : JUNBaseView

#pragma mark - Convenience properties below.

@property(nonatomic, strong, readonly) NSArray<UIView *> *items;
@property(nonatomic, assign, readonly) int mainAxisAlignment;
@property(nonatomic, assign, readonly) int crossAxisAlignment;
@property(nonatomic, assign, readonly, getter=isAspectRatio) bool aspectRatio;

@end

NS_ASSUME_NONNULL_END

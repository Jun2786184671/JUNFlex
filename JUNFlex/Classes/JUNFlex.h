//
//  JUNFlex.h
//  FBSnapshotTestCase
//
//  Created by Jun Ma on 2022/11/27.
//

#import <Foundation/Foundation.h>
#import <JUNFlex/JUNStackBuilder.h>
#import <JUNFlex/JUNStackMeta.h>

#ifndef Horizontal
#define Horizontal JUNFlex.HStack
#endif

#ifndef Vertical
#define Vertical JUNFlex.VStack
#endif

#ifndef Stack
#define Stack JUNFlex.ZStack
#endif

#ifndef jun_alignment
#define jun_alignment(var) kJUNStackAlignment : @(var)
#endif

#ifndef jun_insets
#define jun_insets(t, l, b, r) kJUNStackInsets : [NSValue valueWithUIEdgeInsets:UIEdgeInsetsMake(t, l, b, r)]
#endif

#ifndef jun_insetAll
#define jun_insetAll(a) jun_insets(a, a, a, a)
#endif

#ifndef jun_insetTop
#define jun_insetTop(t) jun_insets(t, 0, 0, 0)
#endif

#ifndef jun_insetLeft
#define jun_insetLeft(l) jun_insets(0, l, 0, 0)
#endif

#ifndef jun_insetBottom
#define jun_insetBottom(b) jun_insets(0, 0, b, 0)
#endif

#ifndef jun_insetRight
#define jun_insetRight(r) jun_insets(0, 0, 0, r)
#endif

//#define JUNHStack(var, ...) jun_stack(JUNFlex.hStack, var, ##__VA_ARGS__, nil);
//#define JUNVStack(var, ...) jun_stack(JUNFlex.vStack, var, ##__VA_ARGS__, nil);
//#define JUNZStack(var, ...) jun_stack(JUNFlex.zStack, var, ##__VA_ARGS__, nil);

NS_ASSUME_NONNULL_BEGIN

//extern UIView *jun_stack(JUNStackBuilder *builder, id buildContext, ...);
//extern UIView *JUNHStack(NSArray<id> *buildContext);
//extern UIView *JUNVStack(NSArray<id> *buildContext);
//extern UIView *JUNZStack(NSArray<id> *buildContext);

@interface JUNFlex : NSObject

@property(class, nonatomic, readonly) JUNStackBuilder *HStack;
@property(class, nonatomic, readonly) JUNStackBuilder *VStack;
@property(class, nonatomic, readonly) JUNStackBuilder *ZStack;

@end

NS_ASSUME_NONNULL_END

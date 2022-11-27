//
//  JUNFlex.h
//  FBSnapshotTestCase
//
//  Created by Jun Ma on 2022/11/27.
//

#import <Foundation/Foundation.h>
#import <JUNFlex/JUNStackBuilder.h>

#ifndef Horizontal
#define Horizontal JUNFlex.HStack
#endif

#ifndef Vertical
#define Vertical JUNFlex.VStack
#endif

typedef enum {
    JUNFlexDirectionHorizontal,
    JUNFlexDirectionVertical,
} JUNFlexDirection;

typedef enum {
    JUNFlexAlignmentMin = 1 << 0,
    JUNFlexAlignmentCenter = 1 << 1,
    JUNFlexAlignmentMax = 1 << 2,
} JUNFlexAlignment;

typedef enum {
    JUNFlexLinearArrangementSpaceBetween,
    JUNFlexLinearArrangementSpaceSurround,
    JUNFlexLinearArrangementSpaceEqual,
} JUNFlexLinearArrangement;

NS_ASSUME_NONNULL_BEGIN

extern NSString * const kJUNFlexAlignment;
extern NSString * const kJUNFlexLinearArrangement;
extern NSString * const kJUNFlexInsets;
extern NSString * const kJUNFlexInsetsAll;
extern NSString * const kJUNFlexInsetsTop;
extern NSString * const kJUNFlexInsetsBottom;
extern NSString * const kJUNFlexInsetsLeft;
extern NSString * const kJUNFlexInsetsRight;

@interface JUNFlex : NSObject

@property(class, nonatomic, readonly) JUNStackBuilder *HStack;
@property(class, nonatomic, readonly) JUNStackBuilder *VStack;

@end

NS_ASSUME_NONNULL_END

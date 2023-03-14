//
//  JUNFlex.h
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/27.
//

#import <Foundation/Foundation.h>
#import <JUNFlex/JUNBaseBuilder.h>
#import <JUNFlex/JUNStackBuilder.h>
#import <JUNFlex/JUNListBuilder.h>
#import <JUNFlex/JUNPaddingBuilder.h>
#import <JUNFlex/JUNItemBuilder.h>
#import <JUNFlex/JUNPropertyBuilder.h>
#import <JUNFlex/UIView+JUNFlex.h>
#import <JUNFlex/UIViewController+JUNFlex.h>

#ifndef Item
    #define Item false.boolValue ? nil : JUNFlex.item
    #ifndef Auto
        #define Auto Item
    #endif
#endif

#ifndef Padding
    #define Padding false.boolValue ? nil : JUNFlex.padding
#endif

#ifndef HStack
    #define HStack false.boolValue ? nil : JUNFlex.hstack
#endif

#ifndef VStack
    #define VStack false.boolValue ? nil : JUNFlex.vstack
#endif

#ifndef ZStack
    #define ZStack false.boolValue ? nil : JUNFlex.zstack
#endif

#ifndef Src
    #define Src(filePath) false.boolValue ? nil : JUNFlex.src(filePath)
#endif

NS_ASSUME_NONNULL_BEGIN

@interface JUNFlex : NSObject

@property(class, nonatomic, readonly) JUNStackBuilder *hstack;
@property(class, nonatomic, readonly) JUNStackBuilder *vstack;
@property(class, nonatomic, readonly) JUNStackBuilder *zstack;
@property(class, nonatomic, readonly) JUNPaddingBuilder *padding;
@property(class, nonatomic, readonly) JUNListBuilder *list;
@property(class, nonatomic, readonly) JUNItemBuilder *item;
@property(class, nonatomic, readonly) JUNPropertyBuilder *(^config)(__kindof UIView *aView);
/// You can pass the path to a json layout file.
@property(class, nonatomic, readonly) __kindof UIView *(^src)(NSString *filePath);

@end

NS_ASSUME_NONNULL_END

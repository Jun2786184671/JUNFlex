//
//  JUNFlex.h
//  FBSnapshotTestCase
//
//  Created by Jun Ma on 2022/11/27.
//

#import <Foundation/Foundation.h>
#import <JUNFlex/JUNStackBuilder.h>
#import <JUNFlex/JUNListBuilder.h>
#import <JUNFlex/JUNPaddingBuilder.h>
#import <JUNFlex/JUNItemBuilder.h>
#import <JUNFlex/JUNModel.h>

#ifndef $Hstack
#define $Hstack JUNFlex.hstack
#endif

#ifndef $Vstack
#define $Vstack JUNFlex.vstack
#endif

#ifndef $Zstack
#define $Zstack JUNFlex.zstack
#endif

#ifndef $Padding
#define $Padding JUNFlex.padding
#endif

#ifndef $Item
#define $Item JUNFlex.item
#endif

#ifndef $List
#define $List JUNFlex.list
#endif

NS_ASSUME_NONNULL_BEGIN

@interface JUNFlex : NSObject

@property(class, nonatomic, readonly) JUNStackBuilder *hstack;
@property(class, nonatomic, readonly) JUNStackBuilder *vstack;
@property(class, nonatomic, readonly) JUNStackBuilder *zstack;
@property(class, nonatomic, readonly) JUNPaddingBuilder *padding;
@property(class, nonatomic, readonly) JUNListBuilder *list;
@property(class, nonatomic, readonly) JUNItemBuilder *item;

@end

NS_ASSUME_NONNULL_END

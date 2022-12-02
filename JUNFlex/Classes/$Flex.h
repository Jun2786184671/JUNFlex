//
//  $Flex.h
//  FBSnapshotTestCase
//
//  Created by Jun Ma on 2022/11/27.
//

#import <Foundation/Foundation.h>
#import <JUNFlex/$AbstractBuilder.h>
#import <JUNFlex/$StackBuilder.h>
#import <JUNFlex/$ListBuilder.h>
#import <JUNFlex/$PaddingBuilder.h>
#import <JUNFlex/$ItemBuilder.h>
#import <JUNFlex/UIView+$Flex.h>
#import <JUNFlex/NSObject+$Model.h>

NS_ASSUME_NONNULL_BEGIN

@interface $Flex : NSObject

@property(class, nonatomic, readonly) $StackBuilder *Hstack;
@property(class, nonatomic, readonly) $StackBuilder *Vstack;
@property(class, nonatomic, readonly) $StackBuilder *Zstack;
@property(class, nonatomic, readonly) $PaddingBuilder *Padding;
@property(class, nonatomic, readonly) $ListBuilder *List;
@property(class, nonatomic, readonly) $ItemBuilder *Item;

@end

extern void $Mapper(Class clz, void (^mapper)(id $, __kindof NSObject *_));
extern void $Layout(Class clz, id (^builder)(__kindof NSObject *_));
extern UIView *$Render(__kindof NSObject *);

NS_ASSUME_NONNULL_END

#ifndef $Hstack
#define $Hstack $Flex.Hstack
#endif

#ifndef $Vstack
#define $Vstack $Flex.Vstack
#endif

#ifndef $Zstack
#define $Zstack $Flex.Zstack
#endif

#ifndef $Padding
#define $Padding $Flex.Padding
#endif

#ifndef $Item
#define $Item $Flex.Item
#endif

#ifndef $List
#define $List $Flex.List
#endif

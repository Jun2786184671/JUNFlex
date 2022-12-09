//
//  JUNFlex.h
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/27.
//

#import <Foundation/Foundation.h>
#import <JUNFlex/JUNAbstractBuilder.h>
#import <JUNFlex/JUNStackBuilder.h>
#import <JUNFlex/JUNListBuilder.h>
#import <JUNFlex/JUNPaddingBuilder.h>
#import <JUNFlex/JUNItemBuilder.h>
#import <JUNFlex/UIView+JUNFlex.h>
#import <JUNFlex/UIViewController+JUNFlex.h>

NS_ASSUME_NONNULL_BEGIN

@interface JUNFlex : NSObject

@property(class, nonatomic, readonly) JUNStackBuilder *Hstack;
@property(class, nonatomic, readonly) JUNStackBuilder *Vstack;
@property(class, nonatomic, readonly) JUNStackBuilder *Zstack;
@property(class, nonatomic, readonly) JUNPaddingBuilder *Padding;
@property(class, nonatomic, readonly) JUNListBuilder *List;
@property(class, nonatomic, readonly) JUNItemBuilder *Item;

@end

NS_ASSUME_NONNULL_END

#ifndef JUNHstack
#define JUNHstack JUNFlex.Hstack
#endif

#ifndef JUNVstack
#define JUNVstack JUNFlex.Vstack
#endif

#ifndef JUNZstack
#define JUNZstack JUNFlex.Zstack
#endif

#ifndef JUNPadding
#define JUNPadding JUNFlex.Padding
#endif

#ifndef JUNItem
#define JUNItem JUNFlex.Item
#endif

#ifndef JUNList
#define JUNList JUNFlex.List
#endif
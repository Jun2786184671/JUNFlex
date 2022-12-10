//
//  JUNFlex.h
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/27.
//

#import <Foundation/Foundation.h>
#import <JUNFlex/JUNItem.h>
#import <JUNFlex/JUNAbstractBuilder.h>
#import <JUNFlex/JUNStackBuilder.h>
#import <JUNFlex/JUNListBuilder.h>
#import <JUNFlex/JUNPaddingBuilder.h>
#import <JUNFlex/JUNItemBuilder.h>
#import <JUNFlex/UIColor+JUNFlex.h>
#import <JUNFlex/UIView+JUNFlex.h>
#import <JUNFlex/UIViewController+JUNFlex.h>

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

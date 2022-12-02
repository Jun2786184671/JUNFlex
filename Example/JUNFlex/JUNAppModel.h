//
//  XZAppModel.h
//  JUNFlex_Example
//
//  Created by Jun Ma on 2022/11/29.
//  Copyright © 2022 Jun Ma. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JUNAppModel : NSObject

@property(nonatomic, copy) NSString *name;
@property(nonatomic, assign) NSUInteger reserveCount;
@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *message;
@property(nonatomic, copy) NSString *image;

@end

NS_ASSUME_NONNULL_END

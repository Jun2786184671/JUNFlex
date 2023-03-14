//
//  JUNBaseProperties.h
//  JUNFlexTool
//
//  Created by Jun Ma on 2022/12/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JUNProperty : NSObject

@property(class, nonatomic, readonly) NSMutableArray<NSString *> *orderedKeys;

@end

NS_ASSUME_NONNULL_END

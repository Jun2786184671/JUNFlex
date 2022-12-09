//
//  $JSONSerializer.h
//  FBSnapshotTestCase
//
//  Created by Jun Ma on 2022/12/9.
//

#import <UIKit/UIKit.h>

@class $AbstractBuilder;

NS_ASSUME_NONNULL_BEGIN

@interface $JSONSerializer : NSObject

+ (instancetype)sharedInstance;

@property(nonatomic, strong, readonly) NSMutableDictionary<NSString *, Class> *builderMapper;
- (UIView *)serialize:(NSDictionary *)json;

@end

NS_ASSUME_NONNULL_END

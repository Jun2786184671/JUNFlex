//
//  JUNJSONSerializer.h
//  FBSnapshotTestCase
//
//  Created by Jun Ma on 2022/12/9.
//

#import <UIKit/UIKit.h>

@class JUNAbstractBuilder;

NS_ASSUME_NONNULL_BEGIN

@interface JUNJSONSerializer : NSObject

+ (instancetype)sharedInstance;

@property(nonatomic, strong, readonly) NSMutableDictionary<NSString *, Class> *builderMapper;
- (UIView *)serialize:(NSDictionary *)json;

@end

NS_ASSUME_NONNULL_END

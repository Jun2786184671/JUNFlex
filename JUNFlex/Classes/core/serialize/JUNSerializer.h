//
//  JUNJSONSerializer.h
//  FBSnapshotTestCase
//
//  Created by Jun Ma on 2022/12/9.
//

#import <UIKit/UIKit.h>

@class JUNBaseProperty;

NS_ASSUME_NONNULL_BEGIN

@interface JUNSerializer : NSObject

+ (instancetype)sharedSerializer;
- (void)registerJsonClassName:(NSString *)className propertyClass:(Class)propertyClass viewClass:(Class)viewClass;

- (__kindof JUNBaseProperty *)serializeJson2Property:(NSDictionary *)json;
- (__kindof UIView *)serializeProperty2View:(__kindof JUNBaseProperty *)property;
- (__kindof UIView *)serializeJson2View:(NSDictionary *)json;
- (__kindof UIView *)serializeJsonFile2View:(NSString *)filePath;

@end

NS_ASSUME_NONNULL_END

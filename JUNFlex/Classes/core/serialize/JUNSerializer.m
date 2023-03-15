//
//  JUNJSONSerializer.m
//  FBSnapshotTestCase
//
//  Created by Jun Ma on 2022/12/9.
//

#import "JUNSerializer.h"
#import "JUNBaseProperty.h"
#import "JUNBaseView.h"
#import <MJExtension/NSObject+MJKeyValue.h>

@interface JUNSerializer ()

@property(nonatomic, strong) NSMutableDictionary<NSString *, Class> *propertyMap;
@property(nonatomic, strong) NSMutableDictionary<NSString *, Class> *viewMap;

@end

@implementation JUNSerializer

+ (instancetype)sharedSerializer {
    static JUNSerializer *serializer = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        serializer = [[self alloc] init];
    });
    return serializer;
}

- (NSMutableDictionary<NSString *,Class> *)propertyMap {
    if (!_propertyMap) {
        _propertyMap = [NSMutableDictionary dictionary];
    }
    return _propertyMap;
}

- (NSMutableDictionary<NSString *,Class> *)viewMap {
    if (!_viewMap) {
        _viewMap = [NSMutableDictionary dictionary];
    }
    return _viewMap;
}

- (void)registerJsonClassName:(NSString *)className propertyClass:(Class)propertyClass viewClass:(Class)viewClass {
    [self.propertyMap setObject:propertyClass forKey:className];
    [self.viewMap setObject:viewClass forKey:className];
}

- (NSDictionary *)serializeJsonFile2Json:(NSString *)filePath {
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        filePath = [[NSBundle mainBundle] pathForResource:filePath ofType:[filePath.pathExtension length] ? nil : @"json"];
    }
    NSAssert(filePath, @"Cannot find layout file.");
    NSData *fileData = [NSData dataWithContentsOfFile:filePath];
    NSError *error = nil;
    id json = [NSJSONSerialization JSONObjectWithData:fileData options:NSJSONReadingFragmentsAllowed error:&error];
    NSAssert(json && !error, @"Layout file json serialize error.");
    NSAssert([json isKindOfClass:[NSDictionary class]], @"Top-level object in layout file must be a dictionary.");
    return json;
}

- (__kindof JUNBaseProperty *)serializeJson2Property:(NSDictionary *)json {
    NSString *clsName = json[kJUNBasePropertyJsonClassName];
    if ([clsName isEqualToString:JUNBasePropertyJsonClassSrc]) {
        NSString *path = json[NSStringFromSelector(@selector(path))];
        NSParameterAssert(path);
        NSDictionary *json = [self serializeJsonFile2Json:path];
        clsName = json[kJUNBasePropertyJsonClassName];
    }
    Class propertyCls = self.propertyMap[clsName];
    NSParameterAssert([propertyCls isSubclassOfClass:[JUNBaseProperty class]]);
    __kindof JUNBaseProperty *property = [propertyCls mj_objectWithKeyValues:json];
    return property;
}

- (__kindof UIView *)serializeProperty2View:(__kindof JUNBaseProperty *)property {
    NSString *clsName = property.jsonClassName;
    Class viewCls = self.viewMap[clsName];
    NSParameterAssert([clsName isEqualToString:JUNBasePropertyJsonClassSrc] || [viewCls isSubclassOfClass:[UIView class]]);
    __kindof UIView *view = [[viewCls alloc] initWithJUNProperty:property];
    return view;
}

- (__kindof UIView *)serializeJson2View:(NSDictionary *)json {
    __kindof JUNBaseProperty *property = [self serializeJson2Property:json];
    __kindof UIView *view = [self serializeProperty2View:property];
    return view;
}

- (__kindof JUNBaseProperty *)serializeJsonFile2Property:(NSString *)filePath {
    id json = [self serializeJsonFile2Json:filePath];
    return [self serializeJson2Property:json];
}

- (__kindof UIView *)serializeJsonFile2View:(NSString *)filePath {
    JUNBaseProperty *property = [self serializeJsonFile2Property:filePath];
    return [self serializeProperty2View:property];
}

@end

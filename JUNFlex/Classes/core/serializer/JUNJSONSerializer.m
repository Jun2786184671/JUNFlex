//
//  JUNJSONSerializer.m
//  FBSnapshotTestCase
//
//  Created by Jun Ma on 2022/12/9.
//

#import "JUNJSONSerializer.h"
#import "JUNAbstractBuilder.h"
#import "JUNItemBuilder.h"

@interface JUNJSONSerializer ()

@property(nonatomic, strong) NSMutableDictionary<NSString *, Class> *builderMapper;

@end

@implementation JUNJSONSerializer

+ (instancetype)sharedInstance {
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (NSMutableDictionary *)builderMapper {
    if (_builderMapper == nil) {
        _builderMapper = [NSMutableDictionary dictionary];
    }
    return _builderMapper;
}

- (UIView *)serialize:(NSDictionary *)json {
    NSString *type = json[@"type"];
    Class builderCls = self.builderMapper[type];
    if (builderCls == nil) {
        builderCls = [JUNItemBuilder class];
    }
    NSParameterAssert([builderCls isSubclassOfClass:[JUNAbstractBuilder class]]);
    
    JUNAbstractBuilder *builder = [[builderCls alloc] init];
    UIView *res = [builder buildWithDictionary:json];
    if (res == nil) {
        NSParameterAssert(false);
        return [[UIView alloc] init];
    }
    return res;
}

@end

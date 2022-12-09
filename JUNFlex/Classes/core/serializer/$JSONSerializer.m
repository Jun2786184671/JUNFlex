//
//  $JSONSerializer.m
//  FBSnapshotTestCase
//
//  Created by Jun Ma on 2022/12/9.
//

#import "$JSONSerializer.h"
#import "$AbstractBuilder.h"
#import "$ItemBuilder.h"

@interface $JSONSerializer ()

@property(nonatomic, strong) NSMutableDictionary<NSString *, Class> *builderMapper;

@end

@implementation $JSONSerializer

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
        builderCls = [$ItemBuilder class];
    }
    NSParameterAssert([builderCls isSubclassOfClass:[$AbstractBuilder class]]);
    
    $AbstractBuilder *builder = [[builderCls alloc] init];
    UIView *res = [builder buildWithDictionary:json];
    if (res == nil) {
        NSParameterAssert(false);
        return [[UIView alloc] init];
    }
    return res;
}

@end

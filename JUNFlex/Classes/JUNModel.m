//
//  JUNContent.m
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/29.
//

#import "JUNModel.h"

@interface JUNModelInfo : NSObject

@property(nonatomic, weak) Class clz;
@property(nonatomic, strong) void (^dataMapper)(id json, JUNModel *);
@property(nonatomic, strong) UIView *(^uiMapper)(JUNModel *model);

@end

@implementation JUNModelInfo

@end


@interface JUNModelManager : NSObject

+ (instancetype)sharedInstance;
- (nullable JUNModelInfo *)modelInfoWithClass:(Class)clz;
- (void)registerModelInfo:(JUNModelInfo *)modelInfo;

@end

@interface JUNModelManager ()

@property(nonatomic, strong) NSMutableDictionary<NSString *, JUNModelInfo *> *modelInfoDict;

@end

@implementation JUNModelManager

+ (instancetype)sharedInstance {
    static JUNModelManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        instance.modelInfoDict = [NSMutableDictionary dictionary];
    });
    return instance;
}

- (JUNModelInfo *)modelInfoWithClass:(Class)clz {
    return [self.modelInfoDict objectForKey:NSStringFromClass(clz)];
}

- (void)registerModelInfo:(JUNModelInfo *)modelInfo {
    JUNModelInfo *existingModelInfo = [self modelInfoWithClass:modelInfo.clz];
    if (existingModelInfo) {
        if (modelInfo.dataMapper) {
            existingModelInfo.dataMapper = modelInfo.dataMapper;
        }
        if (modelInfo.uiMapper) {
            existingModelInfo.uiMapper = modelInfo.uiMapper;
        }
        return;
    }
    [self.modelInfoDict setObject:modelInfo forKey:NSStringFromClass(modelInfo.clz)];
}

@end


@implementation JUNModel

+ (void (^)(void (^ _Nonnull)(id _Nonnull, __kindof JUNModel *)))mapper {
    return ^(void (^builder)(id json, JUNModel *model)) {
        JUNModelInfo *modelInfo = [[JUNModelInfo alloc] init];
        modelInfo.clz = [self class];
        modelInfo.dataMapper = builder;
        [[JUNModelManager sharedInstance] registerModelInfo:modelInfo];
    };
}

+ (void (^)(UIView * _Nonnull (^ _Nonnull)(__kindof JUNModel * _Nonnull)))layout {
    return ^(UIView *(^builder)(JUNModel *)) {
        JUNModelInfo *modelInfo = [[JUNModelInfo alloc] init];
        modelInfo.clz = [self class];
        modelInfo.uiMapper = builder;
        [[JUNModelManager sharedInstance] registerModelInfo:modelInfo];
    };
}

- (__kindof JUNModel * _Nonnull (^)(id _Nonnull))map {
    return ^(id json) {
        JUNModelInfo *modelInfo = [[JUNModelManager sharedInstance] modelInfoWithClass:[self class]];
        if (modelInfo.dataMapper) {
#ifdef DEBUG
            NSAssert(false, @"current model class has not a data mapper");
#endif
            modelInfo.dataMapper(json, self);
        }
        return self;
    };
}

+ (__kindof JUNModel * _Nonnull (^)(id _Nonnull))map {
    return ^(id json) {
        JUNModelInfo *modelInfo = [[JUNModelManager sharedInstance] modelInfoWithClass:[self class]];
        JUNModel *model = [[self alloc] init];
        if (!modelInfo.dataMapper) {
#ifdef DEBUG
            NSAssert(false, @"current model class has not a data mapper");
#endif
            return model;
        }
        modelInfo.dataMapper(json, model);
        return model;
    };
}

- (UIView *)render {
    JUNModelInfo *modelInfo = [[JUNModelManager sharedInstance] modelInfoWithClass:[self class]];
    if (!modelInfo.uiMapper) {
#ifdef DEBUG
        NSAssert(false, @"current model class has not a ui mapper");
#endif
        return [[UIView alloc] init];
    }
    return modelInfo.uiMapper(self);
}

@end

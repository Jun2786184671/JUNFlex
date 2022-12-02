//
//  NSObject+$Model.m
//  JUNFlex
//
//  Created by Jun Ma on 2022/12/2.
//

#import "NSObject+$Model.h"
#import "$ItemBuilder.h"

@interface JUNModelInfo : NSObject

@property(nonatomic, weak) Class clz;
@property(nonatomic, strong) void (^dataMapper)(id json, id);
@property(nonatomic, strong) id (^uiMapper)(id model);

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

@implementation NSObject ($Model)

+ (void (^)(void (^ _Nonnull)(id _Nonnull, __kindof NSObject *)))$mapper {
    return ^(void (^builder)(id json, __kindof NSObject *model)) {
        JUNModelInfo *modelInfo = [[JUNModelInfo alloc] init];
        modelInfo.clz = [self class];
        modelInfo.dataMapper = builder;
        [[JUNModelManager sharedInstance] registerModelInfo:modelInfo];
    };
}

+ (void (^)(id _Nonnull (^ _Nonnull)(__kindof NSObject * _Nonnull)))$layout {
    return ^(id (^builder)(__kindof NSObject *)) {
        JUNModelInfo *modelInfo = [[JUNModelInfo alloc] init];
        modelInfo.clz = [self class];
        modelInfo.uiMapper = builder;
        [[JUNModelManager sharedInstance] registerModelInfo:modelInfo];
    };
}

- (__kindof NSObject * _Nonnull (^)(id _Nonnull))$map {
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

+ (__kindof NSObject * _Nonnull (^)(id _Nonnull))$map {
    return ^(id json) {
        JUNModelInfo *modelInfo = [[JUNModelManager sharedInstance] modelInfoWithClass:[self class]];
        NSObject *model = [[self alloc] init];
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

- (UIView *)$render {
    JUNModelInfo *modelInfo = [[JUNModelManager sharedInstance] modelInfoWithClass:[self class]];
    if (!modelInfo.uiMapper) {
#ifdef DEBUG
        NSAssert(false, @"current model class has not a ui mapper");
#endif
        return [[UIView alloc] init];
    }
    id item = modelInfo.uiMapper(self);
    if ([item isKindOfClass:[$ItemBuilder class]]) {
        $ItemBuilder *builder = ($ItemBuilder *)item;
        return builder.EOB;
    } else if (![item isKindOfClass:[UIView class]]) {
#ifdef DEBUG
        NSAssert(false, @"child of padding must be a uiview or itembuilder");
#endif
        return [[UIView alloc] init];
    }
    return item;
}

@end

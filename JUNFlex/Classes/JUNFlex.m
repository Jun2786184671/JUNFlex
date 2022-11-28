//
//  JUNFlex.m
//  FBSnapshotTestCase
//
//  Created by Jun Ma on 2022/11/27.
//

#import "JUNFlex.h"
#import "JUNHStackBuilder.h"
#import "JUNVStackBuilder.h"
#import "JUNZStackBuilder.h"


//UIView *JUNStack(JUNStackBuilder *builder, NSArray<id> *buildContext) {
//    NSMutableArray<UIView *> *items = [NSMutableArray array];
//    NSDictionary *properties = nil;
//
//    for (id arg in buildContext) {
//        if ([arg isKindOfClass:[NSDictionary class]]) {
//            properties = (NSDictionary *)arg;
//        } else if ([arg isKindOfClass:[UIView class]]) {
//            [items addObject:arg];
//        }
//    }
//    return builder.properties(properties).children(items);
//}
//
//UIView *JUNHStack(NSArray<id> *buildContext) {
//    return JUNStack(JUNFlex.hStack, buildContext);
//}
//
//UIView *JUNVStack(NSArray<id> *buildContext) {
//    return JUNStack(JUNFlex.vStack, buildContext);
//}
//
//
//UIView *JUNZStack(NSArray<id> *buildContext) {
//    return JUNStack(JUNFlex.zStack, buildContext);
//}

//UIView *jun_stack(JUNStackBuilder *builder, id buildContext, ...) {
//    NSMutableArray<UIView *> *items = [NSMutableArray array];
//    NSDictionary *properties = nil;
//    
//    va_list args;
//    va_start(args, buildContext);
//    
//    id arg = buildContext;
//    do {
//        if ([arg isKindOfClass:[NSDictionary class]]) {
//            properties = (NSDictionary *)arg;
//        } else if ([arg isKindOfClass:[UIView class]]) {
//            [items addObject:arg];
//        }
//    } while ((arg = va_arg(args, id)));
//    
//    va_end(args);
//    
//    return builder.properties(properties).children(items);
//}

@implementation JUNFlex

+ (JUNStackBuilder *)HStack {
    return [[JUNHStackBuilder alloc] init];
}

+ (JUNStackBuilder *)VStack {
    return [[JUNVStackBuilder alloc] init];
}

+ (JUNStackBuilder *)ZStack {
    return [[JUNZStackBuilder alloc] init];
}

@end

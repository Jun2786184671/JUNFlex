//
//  UIView+JUNFlex.m
//  JUNFlex
//
//  Created by Jun Ma on 2022/12/1.
//

#import "UIView+JUNFlex.h"
#import "UIView+JUNFlex_Private.h"
#import "JUNSerializer.h"
#import <MJExtension/NSObject+MJKeyValue.h>

@implementation UIView (JUNFlex)

//- (void (^)(NSString * _Nonnull))jun_ID {
//    return ^(NSString *identifier) {
//        self.accessibilityIdentifier = identifier;
//    };
//}

- (NSArray<UIView *> * _Nullable (^)(NSString * _Nonnull))jun_query {
    return ^NSArray<UIView *> *(NSString *identifier) {
        NSMutableArray<UIView *> *results = [NSMutableArray arrayWithCapacity:self.subviews.count + 1];
        if ([self.accessibilityIdentifier isEqualToString:identifier]) {
            [results addObject:self];
        }
        for (UIView *subview in self.subviews) {
            NSArray<UIView *> *result = subview.jun_query(identifier);
            if (result) {
                [results addObjectsFromArray:result];
            }
        }
        return results;
    };
}

- (UIView * _Nullable (^)(NSString * _Nonnull))jun_query0 {
    return ^UIView *(NSString *identifier) {
        if ([self.accessibilityIdentifier isEqualToString:identifier]) return self;
        for (UIView *subview in self.subviews) {
            UIView *result = subview.jun_query0(identifier);
            if (result) return result;
        }
        return nil;
    };
}

- (id)jun_json {
    return [self.jun_property mj_keyValues];
}

- (NSString *)jun_jsonString {
    NSError *err = nil;
    NSJSONWritingOptions opts = NSJSONWritingPrettyPrinted;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self.jun_json options:opts error:&err];
    NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonStr;
}

- (id _Nullable)jun_data {
    return nil;
}

//- (void (^)(NSString * _Nonnull))jun_layout {
//    return ^(NSString *fileName) {
//        [self jun_setContentWithFile:fileName];
//    };
//}

//- (void)jun_setContentWithFile:(NSString *)fileName {
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:[fileName.pathExtension length] ? nil : @"json"];
//    NSAssert(filePath, @"cannot find layout file");
//    NSData *fileData = [NSData dataWithContentsOfFile:filePath];
//    NSError *error = nil;
//    id json = [NSJSONSerialization JSONObjectWithData:fileData options:NSJSONReadingFragmentsAllowed error:&error];
//    NSAssert(json && !error, @"layout file json serialize error");
//    NSAssert([json isKindOfClass:[NSDictionary class]], @"top-level object in layout file must be a dictionary");
//    [self jun_setContentWithDictionary:json];
//}

//- (void)jun_setContentWithDictionary:(NSDictionary *)dict {
//    UIView *contentView = [[JUNJSONSerializer sharedInstance] serialize:dict];
//    [self addSubview:contentView];
//}

@end

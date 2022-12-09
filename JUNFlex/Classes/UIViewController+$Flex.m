//
//  UIViewController+$Flex.m
//  JUNFlex
//
//  Created by Jun Ma on 2022/12/9.
//

#import "UIViewController+$Flex.h"
#import "$JSONSerializer.h"

@implementation UIViewController ($Flex)

- (void (^)(NSString * _Nonnull))layout {
    return ^(NSString *fileName) {
        [self jun_setContentWithFile:fileName];
    };
}

- (void)jun_setContentWithFile:(NSString *)fileName {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:[fileName.pathExtension length] ? nil : @"json"];
    NSAssert(filePath, @"cannot find layout file");
    NSData *fileData = [NSData dataWithContentsOfFile:filePath];
    NSError *error = nil;
    id json = [NSJSONSerialization JSONObjectWithData:fileData options:NSJSONReadingFragmentsAllowed error:&error];
    NSAssert(json && !error, @"layout file json serialize error");
    NSAssert([json isKindOfClass:[NSDictionary class]], @"top-level object in layout file must be a dictionary");
    [self jun_setContentWithDictionary:json];
}

- (void)jun_setContentWithDictionary:(NSDictionary *)dict {
    UIView *contentView = [[$JSONSerializer sharedInstance] serialize:dict];
    [self.view addSubview:contentView];
}

@end

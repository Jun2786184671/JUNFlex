//
//  JUNStack.m
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/27.
//

#import "JUNStack.h"
#import "UIView+JUNFlex_Private.h"

@interface JUNStack ()

@property(nonatomic, strong) NSArray<UIView *> *items;

@property(nonatomic, assign) int mainAxisAlignment;
@property(nonatomic, assign) int crossAxisAlignment;
@property(nonatomic, assign, getter=isAspectRatio) bool aspectRatio;

@end

@implementation JUNStack

- (instancetype)initWithItems:(NSArray<UIView *> *)items mainAxisAlignment:(int)mainAxisAlignment crossAxisAlignment:(int)crossAxisAlignment aspectRatio:(bool)aspectRatio {
    if (self = [super init]) {
        self.items = items;
        self.mainAxisAlignment = mainAxisAlignment;
        self.crossAxisAlignment = crossAxisAlignment;
        self.aspectRatio = aspectRatio;
    }
    return self;
}

@end

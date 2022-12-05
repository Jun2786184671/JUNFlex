//
//  JUNStack.m
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/27.
//

#import "$Stack.h"
#import "UIView+JUNex4Flex.h"

@interface $Stack ()

@property(nonatomic, strong) NSArray<UIView *> *items;

@property(nonatomic, assign) int mainAxisAlignment;
@property(nonatomic, assign) int crossAxisAlignment;

@end

@implementation $Stack

- (instancetype)initWithItems:(NSArray<UIView *> *)items mainAxisAlignment:(int)mainAxisAlignment crossAxisAlignment:(int)crossAxisAlignment {
    if (self = [super init]) {
        self.items = items;
        self.mainAxisAlignment = mainAxisAlignment;
        self.crossAxisAlignment = crossAxisAlignment;
    }
    return self;
}

@end

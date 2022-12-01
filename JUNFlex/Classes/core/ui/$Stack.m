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
@property(nonatomic, assign) CGPoint alignment;

@end

@implementation $Stack

- (instancetype)initWithItems:(NSArray<UIView *> *)items alignment:(CGPoint)alignment {
    if (self = [super init]) {
        self.items = items;
        self.alignment = alignment;
    }
    return self;
}

@end

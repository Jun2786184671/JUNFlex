//
//  $StackBuilder.m
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/27.
//

#import "$StackBuilder.h"
#import "$StackBuilder+Private.h"
#import "$AbstractBuilder+Private.h"
#import "$Stack.h"

@interface $StackBuilder ()

@property(nonatomic, strong) $Item *$product;

@property(nonatomic, assign) int mainAxisAlignment;
@property(nonatomic, assign) int crossAxisAlignment;

@end

@implementation $StackBuilder

- (id)product {
    return self.$product;
}

- ($Item *)$product {
    if (_$product == nil) {
        _$product = [[$Item alloc] init];
    }
    return _$product;
}

- ($StackBuilder * _Nonnull (^)(int, int))align {
    return ^(int mainAxisAlignment, int crossAxisAlignment) {
        self.mainAxisAlignment = mainAxisAlignment;
        self.crossAxisAlignment = crossAxisAlignment;
        return self;
    };
}

// build method
- (UIView * _Nonnull (^)(NSArray<id> * _Nonnull))children {
    return ^(NSArray<UIView *> *children) {
        if (children.count == 0) {
            NSAssert(false, @"stack must contain at least onw child");
            return self.EOB;
        }
        
        NSArray<UIView *> *$children = [self _validateChildren:children];
        $Stack *stack = [self _getProductWithChildren:$children mainAxisAlignment:self.mainAxisAlignment crossAxisAlignment:self.crossAxisAlignment];
        
        stack.translatesAutoresizingMaskIntoConstraints = false;
        [self.$product addSubview:stack];
        [self.$product addConstraints:@[
            [NSLayoutConstraint constraintWithItem:stack attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.$product attribute:NSLayoutAttributeTop multiplier:1.0f constant:0.0f],
            [NSLayoutConstraint constraintWithItem:stack attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.$product attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0.0f],
            [NSLayoutConstraint constraintWithItem:stack attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.$product attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0.0f],
            [NSLayoutConstraint constraintWithItem:stack attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.$product attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0.0f],
        ]];
        return self.EOB;
    };
}

- (NSArray<UIView *> *)_validateChildren:(NSArray<id> *)children {
    NSMutableArray *$children = [NSMutableArray arrayWithArray:children];
    for (int i = 0; i < children.count; i++) {
        id child = children[i];
        if ([child isKindOfClass:[$ItemBuilder class]]) {
            $ItemBuilder *builder = ($ItemBuilder *)child;
            [$children replaceObjectAtIndex:i withObject:builder.EOB];
        }
    }
    return [$children copy];
}

- ($Stack *)_getProductWithChildren:(NSArray<id> *)children alignment:(CGPoint)alignment {
    return nil;
}

@end

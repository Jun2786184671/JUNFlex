//
//  JUNFlexBuilder.m
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/27.
//

#import "JUNStackBuilder.h"
#import "JUNStackBuilder+Private.h"
#import "JUNItemBuilder+Private.h"
#import "JUNStack.h"
#import "JUNItemBuilder.h"

@interface JUNStackBuilder ()

@property(nonatomic, copy) NSString *$ID;
@property(nonatomic, strong) UIColor *$color;
@property(nonatomic, assign) CGFloat $alpha;
@property(nonatomic, assign) CGFloat $radius;
@property(nonatomic, assign) CGFloat $width;
@property(nonatomic, assign) CGFloat $height;
@property(nonatomic, assign) CGPoint $align;
@property(nonatomic, assign) bool $maskBounds;

@end

@implementation JUNStackBuilder

- (JUNStackBuilder * _Nonnull (^)(CGPoint))align {
    return ^(CGPoint align) {
        self.$align = align;
        return self;
    };
}

// build method
- (UIView * _Nonnull (^)(NSArray<UIView *> * _Nonnull))children {
    return ^(NSArray<UIView *> *items) {
        if (items.count == 0) {
            NSAssert(false, @"stack must contain at least onw child");
            return [[UIView alloc] init];
        }
        
        NSArray<UIView *> *validItems = [self _validateItems:items];
        JUNStack *stack = [self _getStackWithItems:validItems alignment:self.$align];
        
        stack.translatesAutoresizingMaskIntoConstraints = false;
        [self.target addSubview:stack];
        [self.target addConstraints:@[
            [NSLayoutConstraint constraintWithItem:stack attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.target attribute:NSLayoutAttributeTop multiplier:1.0f constant:0.0f],
            [NSLayoutConstraint constraintWithItem:stack attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.target attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0.0f],
            [NSLayoutConstraint constraintWithItem:stack attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.target attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0.0f],
            [NSLayoutConstraint constraintWithItem:stack attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.target attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0.0f],
        ]];
        return (UIView *)self.target;
    };
}

- (NSArray<UIView *> *)_validateItems:(NSArray<UIView *> *)items {
    NSMutableArray *validItems = [NSMutableArray arrayWithArray:items];
    for (int i = 0; i < items.count; i++) {
        id item = items[i];
        if ([item isKindOfClass:[JUNItemBuilder class]]) {
            JUNItemBuilder *builder = (JUNItemBuilder *)item;
            [validItems replaceObjectAtIndex:i withObject:builder.end];
        }
    }
    return [validItems copy];
}

- (JUNStack *)_getStackWithItems:(NSArray<UIView *> *)items alignment:(CGPoint)alignment {
    return nil;
}

@end

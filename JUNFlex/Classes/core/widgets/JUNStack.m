//
//  JUNStack.m
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/27.
//

#import "JUNStack.h"

@interface JUNStack ()

@property(nonatomic, strong) NSArray<UIView *> *items;

@property(nonatomic, assign) int mainAxisAlignment;
@property(nonatomic, assign) int crossAxisAlignment;
@property(nonatomic, assign, getter=isAspectRatio) bool aspectRatio;

@end

@implementation JUNStack

- (void)jun_setProperty:(__kindof JUNBaseProperty *)property {
    [super jun_setProperty:property];
    [self _removeAllSubviews];
    JUNStackProperty *stackProperty = property;
    self.mainAxisAlignment = [stackProperty.align.main intValue];
    self.crossAxisAlignment = [stackProperty.align.cross intValue];
    self.aspectRatio = [stackProperty.aspectRatio boolValue];
    self.items = stackProperty.childrenViews;
}

- (void)_removeAllSubviews {
    for (UIView *subview in self.subviews) {
        [subview removeFromSuperview];
    }
}

@end

//
//  UIView+JUNex4Flex.m
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/28.
//

#import "UIView+JUNFlex_Private.h"
#import "UIView+JUNFlex.h"
#import "JUNItem.h"
#import "JUNSizeProperty.h"
#import "JUNSerializer.h"
#import "UIColor+JUNFlex_Private.h"

#define JUNSystemLayoutConstraintNumberLimit 2777777.0f

@implementation UIView (JUNFlex_Private)

+ (void)load {
    JUNSerializer *serializer = [JUNSerializer sharedSerializer];
    NSString *jsonClassName = [self jun_getJsonClassName];
    Class propertyClass = [self jun_getPropertyClass];
    [serializer registerJsonClassName:jsonClassName propertyClass:propertyClass viewClass:[self class]];
}

+ (NSString *)jun_getJsonClassName {
    return @"undefined";
}

+ (Class)jun_getPropertyClass {
    return [JUNBaseProperty class];
}

- (instancetype)initWithJUNProperty:(__kindof JUNBaseProperty *)property {
    if (self = [self init]) {
        [self jun_setProperty:property];
    }
    return self;
}

- (CGRect)jun_validateFrame {
    CGRect frame = self.frame;
    CGFloat w = frame.size.width;
    CGFloat h = frame.size.height;
    if (!w || w == CGFLOAT_MIN || !h || h == CGFLOAT_MIN) {
        [self sizeToFit];
        frame.size.width = w ?: self.frame.size.width;
        frame.size.height = h ?: self.frame.size.height;
        self.frame = frame;
    }
    return frame;
}

- (void)jun_setHeight:(CGFloat)height {
    height = [self jun_getLengthWithFloat:height];
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:height];
    if (height >= JUNSystemLayoutConstraintNumberLimit) {
        heightConstraint.priority = UILayoutPriorityDefaultHigh + 1;
    } else if (height == 0) {
        heightConstraint.priority = UILayoutPriorityDefaultHigh;
    } else {
        heightConstraint.priority = UILayoutPriorityRequired - 1;
    }
    [self addConstraint:heightConstraint];
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (void)jun_setWidth:(CGFloat)width {
    width = [self jun_getLengthWithFloat:width];
    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:width];
    if (width >= JUNSystemLayoutConstraintNumberLimit) {
        widthConstraint.priority = UILayoutPriorityDefaultHigh + 1;
    } else if (width == 0) {
        widthConstraint.priority = UILayoutPriorityDefaultHigh;
    } else {
        widthConstraint.priority = UILayoutPriorityRequired - 1;
    }
    [self addConstraint:widthConstraint];
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)jun_setProperty:(__kindof JUNBaseProperty *)property {
    if (property.ID) {
        self.accessibilityIdentifier = property.ID;
    }
    if ([self respondsToSelector:@selector(jun_setData:)]) {
        [self performSelector:@selector(jun_setData:) withObject:property.data];
    }
    if (property.color) {
        self.backgroundColor = [UIColor jun_colorWithProperty:property.color];
    }
    if (property.alpha) {
        self.alpha = [property.alpha floatValue];
    }
    if (property.radius) {
        self.layer.cornerRadius = [property.radius floatValue];
    }
    if (property.border) {
        JUNBorderProperty *border = property.border;
        if (border.width) {
            self.layer.borderWidth = [border.width floatValue];
        }
        if (border.color) {
            self.layer.borderColor = [UIColor jun_colorWithProperty:border.color].CGColor;
        }
    }
    if (property.maskBounds) {
        self.layer.masksToBounds = [property.maskBounds boolValue];
    }
    if (property.size) {
        JUNSizeProperty *size = property.size;
        if (size.width) {
            [self jun_setWidth:[size.width floatValue]];
        }
        if (size.height) {
            [self jun_setHeight:[size.height floatValue]];
        }
    }
}

- (__kindof JUNBaseProperty *)jun_property {
    JUNBaseProperty *property = [[JUNBaseProperty alloc] init];
    property.ID = self.accessibilityIdentifier;
    property.data = self.jun_data;
    property.color = [[JUNColorProperty alloc] initWithColor:self.backgroundColor];
    property.alpha = @(self.alpha);
    property.radius = @(self.layer.cornerRadius);
    JUNBorderProperty *border = [[JUNBorderProperty alloc] init];
    border.width = @(self.layer.borderWidth);
    border.color = [[JUNColorProperty alloc] initWithColor:[UIColor colorWithCGColor:self.layer.borderColor]];
    property.border = border;
    property.maskBounds = @(self.layer.masksToBounds);
    JUNSizeProperty *size = [[JUNSizeProperty alloc] init];
    size.width = @(self.bounds.size.width);
    size.height = @(self.bounds.size.height);
    property.size = size;
    return property;
}

- (CGFloat)jun_getLengthWithFloat:(CGFloat)value {
    if (value == CGFLOAT_MIN) return 0;
    if (value > JUNSystemLayoutConstraintNumberLimit || value < 0) return JUNSystemLayoutConstraintNumberLimit;
    return value;
}

@end

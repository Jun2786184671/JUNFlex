//
//  JUNHStack.m
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/27.
//

#import "JUNHStack.h"

@implementation JUNHStack
JUN_REGISTER_CLASS(@"hstack", [JUNStackProperty class]);

- (bool)isHorizontal {
    return true;
}

@end

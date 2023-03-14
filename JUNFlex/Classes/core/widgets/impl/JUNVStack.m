//
//  JUNVStack.m
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/27.
//

#import "JUNVStack.h"

@implementation JUNVStack
JUN_REGISTER_CLASS(@"vstack", [JUNStackProperty class]);

- (bool)isHorizontal {
    return false;
}

@end

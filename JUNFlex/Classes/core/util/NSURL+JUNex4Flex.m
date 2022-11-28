//
//  NSURL+JUNex4Flex.m
//  JUNFlex
//
//  Created by Jun Ma on 2022/11/29.
//

#import "NSURL+JUNex4Flex.h"

@implementation NSURL (JUNex4Flex)

- (bool)jun_isValid {
    return self.scheme.length && self.host.length && self.path.length;
}

@end

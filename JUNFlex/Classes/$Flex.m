//
//  JUNFlex.m
//  FBSnapshotTestCase
//
//  Created by Jun Ma on 2022/11/27.
//

#import "$Flex.h"
#import "JUNHStackBuilder.h"
#import "JUNVStackBuilder.h"
#import "JUNZStackBuilder.h"

@implementation $Flex

+ ($StackBuilder *)Hstack {
    return [[JUNHStackBuilder alloc] init];
}

+ ($StackBuilder *)Vstack {
    return [[JUNVStackBuilder alloc] init];
}

+ ($StackBuilder *)Zstack {
    return [[JUNZStackBuilder alloc] init];
}

+ ($ListBuilder *)List {
    return [[$ListBuilder alloc] init];
}

+ ($PaddingBuilder *)Padding {
    return [[$PaddingBuilder alloc] init];
}

+ ($ItemBuilder *)Item {
    return [[$ItemBuilder alloc] init];
}

@end

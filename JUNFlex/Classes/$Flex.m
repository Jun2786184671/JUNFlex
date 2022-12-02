//
//  $Flex.m
//  FBSnapshotTestCase
//
//  Created by Jun Ma on 2022/11/27.
//

#import "$Flex.h"
#import "$HStackBuilder.h"
#import "$VStackBuilder.h"
#import "$ZStackBuilder.h"

@implementation $Flex

+ ($StackBuilder *)Hstack {
    return [[$HStackBuilder alloc] init];
}

+ ($StackBuilder *)Vstack {
    return [[$VStackBuilder alloc] init];
}

+ ($StackBuilder *)Zstack {
    return [[$ZStackBuilder alloc] init];
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

void $Mapper(Class clz, void (^mapper)(id $, __kindof NSObject *_)) {
    [clz $mapper](mapper);
}

void $Layout(Class clz, id (^builder)(__kindof NSObject *_)) {
    [clz $layout](builder);
}

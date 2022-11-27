//
//  JUNFlex.m
//  FBSnapshotTestCase
//
//  Created by Jun Ma on 2022/11/27.
//

#import "JUNFlex.h"
#import "JUNHStackBuilder.h"
#import "JUNVStackBuilder.h"

@implementation JUNFlex

+ (JUNStackBuilder *)HStack {
    return [JUNHStackBuilder sharedInstance];
}

+ (JUNStackBuilder *)VStack {
    return [JUNVStackBuilder sharedInstance];
}

@end

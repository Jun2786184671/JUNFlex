//
//  JUNJSONSerializer+Private.h
//  JUNFlex
//
//  Created by Jun Ma on 2022/12/10.
//

#import <JUNFlex/JUNFlex.h>

NS_ASSUME_NONNULL_BEGIN

@interface JUNJSONSerializer ()

@property(nonatomic, strong, readonly) NSMutableDictionary<NSString *, Class> *builderMapper;

@end

NS_ASSUME_NONNULL_END

//
//  SimpleTokenReader.h
//  MyCompiler
//
//  Created by 郭顺 on 2019/8/26.
//  Copyright © 2019 郭顺. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TokenProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@interface SimpleTokenReader : NSObject<TokenReaderProtocol>
- (instancetype)initWithTokens:(NSArray<id<TokenProtocol>> *)tokens;
@end

NS_ASSUME_NONNULL_END

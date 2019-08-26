//
//  TokenProtocol.h
//  MyCompiler
//
//  Created by 郭顺 on 2019/8/26.
//  Copyright © 2019 郭顺. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "TypeDef.h"
#ifndef TokenProtocol_h
#define TokenProtocol_h


@protocol TokenProtocol <NSObject>

- (TokenType)getTokenType;
- (NSString *)getTokenText;

@end

@protocol TokenReaderProtocol <NSObject>

- (id<TokenProtocol>) read;
- (id<TokenProtocol>) peek;

- (void)unRead;
- (NSInteger) getPosition;
- (void)setPosition:(NSInteger)position;
@end

#endif /* TokenProtocol_h */

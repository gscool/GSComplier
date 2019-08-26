//
//  SimpleTokenReader.m
//  MyCompiler
//
//  Created by 郭顺 on 2019/8/26.
//  Copyright © 2019 郭顺. All rights reserved.
//

#import "SimpleTokenReader.h"

@interface SimpleTokenReader ()
@property(nonatomic, strong)NSMutableArray<id<TokenProtocol>> *tokens;
@property(nonatomic, assign)NSInteger pos;
@end

@implementation SimpleTokenReader

- (instancetype)initWithTokens:(NSArray<id<TokenProtocol>> *)tokens{
    self = [super init];
    if (self) {
        _pos = 0;
        _tokens = [[NSMutableArray alloc]initWithArray:tokens];
    }
    return self;
}

- (NSInteger)getPosition {
    return _pos;
}

- (id<TokenProtocol>)peek {
    if (_pos < _tokens.count) {
        return [_tokens objectAtIndex:_pos];
    }
    return nil;
}

- (id<TokenProtocol>)read {
    if (_pos < _tokens.count) {
        return [_tokens objectAtIndex:_pos++];
    }
    return nil;
}

- (void)setPosition:(NSInteger)position {
    if (position >=0 && position < _tokens.count){
        _pos = position;
    }
}

- (void)unRead {
    if (_pos > 0) {
        _pos--;
    }
}

@end

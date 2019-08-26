//
//  LexerTest.m
//  MyCompiler
//
//  Created by 郭顺 on 2019/8/26.
//  Copyright © 2019 郭顺. All rights reserved.
//

#import "LexerTest.h"
#import "TokenProtocol.h"
#import "GSLexer.h"
@implementation LexerTest
- (void)test{
    GSLexer *lexer = [[GSLexer alloc]init];
    NSString *script = @"int age = 45;";
    SimpleTokenReader *tokenReader = [lexer tokenize:script];
    [self dump:tokenReader];
    
    script = @"inta age = 45;";
    tokenReader = [lexer tokenize:script];
    [self dump:tokenReader];
    
    script = @"age >= 38;";
    tokenReader = [lexer tokenize:script];
    [self dump:tokenReader];
}

- (void)dump:(SimpleTokenReader *)tokenReader{
    NSLog(@"\n=====================\ntext\t\ttype");
    id<TokenProtocol> token = [tokenReader read];
    while (token) {
        NSLog(@"%@\t\t%ld",[token getTokenText],(long)[token getTokenType]);
        token = [tokenReader read];
    }
}
@end

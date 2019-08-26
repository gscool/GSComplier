//
//  GSLexer.m
//  MyCompiler
//
//  Created by 郭顺 on 2019/8/26.
//  Copyright © 2019 郭顺. All rights reserved.
//

#import "GSLexer.h"
#import "TypeDef.h"
#import "SimpleToken.h"
#import "TokenProtocol.h"


@interface GSLexer ()
@property(nonatomic, strong)NSString *tokenText;
@property(nonatomic, strong)SimpleToken *token;
@property(nonatomic, strong)NSMutableArray<id<TokenProtocol>> *tokens;
@end

@implementation GSLexer

- (BOOL)isAlpha:(int)ch{
    return (ch >= 'a' && ch <= 'z') || (ch >= 'A' && ch <= 'Z');
}

- (BOOL)isDigit:(int)ch{
    return ch >= '0' && ch <= '9';
}

- (BOOL)isBlank:(int)ch{
    return ch == ' ' || ch == '\t' || ch == '\n';
}

- (DfaState)initToken:(char)ch{
    if (_tokenText.length > 0) {
        _token.text = [[NSString alloc]initWithString:_tokenText];
        [_tokens addObject:_token];
        
        _tokenText = @"";
        _token = [[SimpleToken alloc]init];
    }
    
    DfaState newState = DfaState_Initial;
    if ([self isAlpha:ch]) {
        if (ch == 'i') {
            newState = DfaState_Id_int1;
        } else {
            newState = DfaState_Id; //进入Id状态
        }
        
        _token.type = TokenType_Identifier;
        
        _tokenText = [_tokenText stringByAppendingString:[NSString stringWithFormat:@"%c", ch]];
    } else if ([self isDigit:ch]) {       //第一个字符是数字
        newState = DfaState_IntLiteral;
        _token.type = TokenType_IntLiteral;
        _tokenText = [_tokenText stringByAppendingString:[NSString stringWithFormat:@"%c", ch]];
    } else if (ch == '>') {         //第一个字符是>
        newState = DfaState_GT;
        _token.type = TokenType_GT;
        _tokenText = [_tokenText stringByAppendingString:[NSString stringWithFormat:@"%c", ch]];
    } else if (ch == '+') {
        newState = DfaState_Plus;
        _token.type = TokenType_Plus;
        _tokenText = [_tokenText stringByAppendingString:[NSString stringWithFormat:@"%c", ch]];
    } else if (ch == '-') {
        newState = DfaState_Minus;
        _token.type = TokenType_Minus;
        _tokenText = [_tokenText stringByAppendingString:[NSString stringWithFormat:@"%c", ch]];
    } else if (ch == '*') {
        newState = DfaState_Star;
        _token.type = TokenType_Star;
        _tokenText = [_tokenText stringByAppendingString:[NSString stringWithFormat:@"%c", ch]];
    } else if (ch == '/') {
        newState = DfaState_Slash;
        _token.type = TokenType_Slash;
        _tokenText = [_tokenText stringByAppendingString:[NSString stringWithFormat:@"%c", ch]];
    } else if (ch == ';') {
        newState = DfaState_SemiColon;
        _token.type = TokenType_SemiColon;
        _tokenText = [_tokenText stringByAppendingString:[NSString stringWithFormat:@"%c", ch]];
    } else if (ch == '(') {
        newState = DfaState_LeftParen;
        _token.type = TokenType_LeftParen;
        _tokenText = [_tokenText stringByAppendingString:[NSString stringWithFormat:@"%c", ch]];
    } else if (ch == ')') {
        newState = DfaState_RightParen;
        _token.type = TokenType_RightParen;
        _tokenText = [_tokenText stringByAppendingString:[NSString stringWithFormat:@"%c", ch]];
    } else if (ch == '=') {
        newState = DfaState_Assignment;
        _token.type = TokenType_Assignment;
        _tokenText = [_tokenText stringByAppendingString:[NSString stringWithFormat:@"%c", ch]];
    } else {
        newState = DfaState_Initial; // skip all unknown patterns
    }
    return newState;
}

#pragma mark - public
- (SimpleTokenReader *)tokenize:(NSString *)script{
    _tokens = [[NSMutableArray alloc]init];
    _tokenText = @"";
    _token = [[SimpleToken alloc]init];
    
//    int ich = 0;
    char ch = 0;
    DfaState state = DfaState_Initial;
    
    for (int i=0; i<script.length; i++) {
        ch = [script characterAtIndex:i];
        switch (state) {
            case DfaState_Initial:
                state = [self initToken:ch];
                break;
            case DfaState_Id:
                if ([self isAlpha:ch] || [self isDigit:ch]) {
                    _tokenText = [_tokenText stringByAppendingString:[NSString stringWithFormat:@"%c", ch]];   //保持标识符状态
                } else {
                    state = [self initToken:ch];      //退出标识符状态，并保存Token
                }
                break;
            case DfaState_GT:
                if (ch == '=') {
                    _token.type = TokenType_GE;  //转换成GE
                    state = DfaState_GE;
                    _tokenText = [_tokenText stringByAppendingString:[NSString stringWithFormat:@"%c", ch]];
                } else {
                    state = [self initToken:ch];      //退出GT状态，并保存Token
                }
                break;
            case DfaState_GE:
            case DfaState_Assignment:
            case DfaState_Plus:
            case DfaState_Minus:
            case DfaState_Star:
            case DfaState_Slash:
            case DfaState_SemiColon:
            case DfaState_LeftParen:
            case DfaState_RightParen:
                state = [self initToken:ch];          //退出当前状态，并保存Token
                break;
            case DfaState_IntLiteral:
                if ([self isDigit:ch]) {
                    _tokenText = [_tokenText stringByAppendingString:[NSString stringWithFormat:@"%c", ch]];       //继续保持在数字字面量状态
                } else {
                    state = [self initToken:ch];      //退出当前状态，并保存Token
                }
                break;
            case DfaState_Id_int1:
                if (ch == 'n') {
                    state = DfaState_Id_int2;
                    _tokenText = [_tokenText stringByAppendingString:[NSString stringWithFormat:@"%c", ch]];
                }
                else if ([self isDigit:ch] || [self isAlpha:ch]){
                    state = DfaState_Id;    //切换回Id状态
                    _tokenText = [_tokenText stringByAppendingString:[NSString stringWithFormat:@"%c", ch]];
                }
                else {
                    state = [self initToken:ch];
                }
                break;
            case DfaState_Id_int2:
                if (ch == 't') {
                    state = DfaState_Id_int3;
                    _tokenText = [_tokenText stringByAppendingString:[NSString stringWithFormat:@"%c", ch]];
                }
                else if ([self isDigit:ch] || [self isAlpha:ch]){
                    state = DfaState_Id;    //切换回id状态
                    _tokenText = [_tokenText stringByAppendingString:[NSString stringWithFormat:@"%c", ch]];
                }
                else {
                    state = [self initToken:ch];
                }
                break;
            case DfaState_Id_int3:
                if ([self isBlank:ch]) {
                    _token.type = TokenType_Int;
                    state = [self initToken:ch];
                }
                else{
                    state = DfaState_Id;    //切换回Id状态
                    _tokenText = [_tokenText stringByAppendingString:[NSString stringWithFormat:@"%c", ch]];
                }
                break;
            default:
                break;
        }
    }
    
    if (_tokenText.length > 0) {
        [self initToken:ch];
    }
    
    return [[SimpleTokenReader alloc]initWithTokens:_tokens];
}
@end

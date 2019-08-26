//
//  TypeDef.h
//  MyCompiler
//
//  Created by 郭顺 on 2019/8/26.
//  Copyright © 2019 郭顺. All rights reserved.
//
#import <Foundation/Foundation.h>
#ifndef TypeDef_h
#define TypeDef_h

typedef NS_ENUM(NSInteger,DfaState){
    DfaState_Initial,
    
    DfaState_If, DfaState_Id_if1, DfaState_Id_if2, DfaState_Else, DfaState_Id_else1, DfaState_Id_else2, DfaState_Id_else3, DfaState_Id_else4,
    
    DfaState_Int, DfaState_Id_int1, DfaState_Id_int2, DfaState_Id_int3, DfaState_Id,
    DfaState_GT,
    DfaState_GE,
    
    DfaState_Assignment,
    
    DfaState_Plus, DfaState_Minus, DfaState_Star, DfaState_Slash,
    
    DfaState_SemiColon,
    DfaState_LeftParen,
    DfaState_RightParen,
    
    DfaState_IntLiteral
};

typedef NS_ENUM(NSInteger,TokenType){
    TokenType_Plus,
    TokenType_Minus,  // -
    TokenType_Star,   // *
    TokenType_Slash,  // /
    
    TokenType_GE,     // >=
    TokenType_GT,     // >
    TokenType_EQ,     // ==
    TokenType_LE,     // <=
    TokenType_LT,     // <
    
    TokenType_SemiColon, // ;
    TokenType_LeftParen, // (
    TokenType_RightParen,// )
    
    TokenType_Assignment,// =
    
    TokenType_If,
    TokenType_Else,
    
    TokenType_Int,
    
    TokenType_Identifier,     //标识符
    
    TokenType_IntLiteral,     //整型字面量
    TokenType_StringLiteral   //字符串字面量    Plus,   // +
};

#endif /* TypeDef_h */

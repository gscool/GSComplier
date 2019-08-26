//
//  SimpleToken.m
//  MyCompiler
//
//  Created by 郭顺 on 2019/8/26.
//  Copyright © 2019 郭顺. All rights reserved.
//

#import "SimpleToken.h"

@interface SimpleToken ()

@end

@implementation SimpleToken

- (NSString *)getTokenText {
    return _text;
}

- (TokenType)getTokenType {
    return _type;
}

@end

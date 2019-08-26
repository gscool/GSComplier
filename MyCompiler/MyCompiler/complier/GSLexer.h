//
//  GSLexer.h
//  MyCompiler
//
//  Created by 郭顺 on 2019/8/26.
//  Copyright © 2019 郭顺. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SimpleTokenReader.h"
NS_ASSUME_NONNULL_BEGIN

@interface GSLexer : NSObject

- (SimpleTokenReader *)tokenize:(NSString *)script;

@end

NS_ASSUME_NONNULL_END

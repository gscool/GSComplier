//
//  ViewController.m
//  MyCompiler
//
//  Created by 郭顺 on 2019/8/26.
//  Copyright © 2019 郭顺. All rights reserved.
//

#import "ViewController.h"
#import "LexerTest.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    LexerTest *test = [[LexerTest alloc]init];
    [test test];
}


@end

//
//  ViewController.m
//  RunLoopDemo
//
//  Created by belief on 2018/7/20.
//  Copyright © 2018年 PRG. All rights reserved.
//

#import "ViewController.h"
#import "RGThread.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    RGThread *thread = [[RGThread alloc] initWithTarget:self selector:@selector(run) object:nil];
    [thread start];
    
}

-(void)run {
    
    NSLog(@"%s---%@",__func__,[NSThread currentThread]);
    
}


@end

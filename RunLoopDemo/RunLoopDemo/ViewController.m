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
@property (nonatomic, strong) RGThread *thread;
@property (nonatomic, assign,getter=isStoped) BOOL stoped;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof(self) weakSelf = self;
    
    self.stoped = NO;
    
    self.thread = [[RGThread alloc] initWithBlock:^{
        NSLog(@"----begin----%@",[NSThread currentThread]);
        //往RunLoop中添加source/Timer/Observer
        [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc] init] forMode:NSDefaultRunLoopMode];
        while (weakSelf && !weakSelf.isStoped) {
            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        }
        NSLog(@"----end----%@",[NSThread currentThread]);
        
    }];
    [self.thread start];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.thread == nil) {
        return;
    }
    // wait 如果是YES,意思就是执行完test，再回来执行后面的代码，如果是NO，就是不等执行完test，就直接执行
    [self performSelector:@selector(test) onThread:self.thread withObject:nil waitUntilDone:NO];
    NSLog(@"1111");
}
//停止
- (IBAction)stop {
    
    if (self.thread == nil) {
        return;
    }
    // wait 如果是YES,意思就是执行完test，再回来执行后面的代码，如果是NO，就是不等执行完test，就直接执行
    [self performSelector:@selector(stopThread) onThread:self.thread withObject:nil waitUntilDone:YES];
}

//停止RunLoop
-(void)stopThread {
    
    self.stoped = YES;
    //停止RunLoop
    CFRunLoopStop(CFRunLoopGetCurrent());
    NSLog(@"%s  %@",__func__,[NSThread currentThread]);
    
    //清空线程
    self.thread = nil;
    
}

//执行的任务
-(void)test {
    
    NSLog(@"%s---%@",__func__,[NSThread currentThread]);
}

-(void)dealloc
{
    NSLog(@"%s",__func__);
    [self stop];
}

@end

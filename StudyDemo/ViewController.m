//
//  ViewController.m
//  StudyDemo
//
//  Created by xiaodou on 2016/10/27.
//  Copyright © 2016年 xiaodouxiaodou. All rights reserved.
//

#import "ViewController.h"
#import "FTTimerUtil.h"

@interface ViewController ()

@property (nonatomic, strong) UIButton *button1;      /**< 倒计时按钮 */
@property (nonatomic, strong) UIButton *button2;      /**< 顺计时按钮 */

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self setupSubviews];
}

- (void)setupSubviews {
    _button1 = [[UIButton alloc] initWithFrame:CGRectMake(120, 200, 100, 40)];
    [_button1 setTitle:@"倒计时" forState:UIControlStateNormal];
    _button1.backgroundColor = [UIColor orangeColor];
    [_button1 addTarget:self action:@selector(timingTest1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_button1];
    
    _button2 = [[UIButton alloc] initWithFrame:CGRectMake(120, 300, 100, 40)];
    [_button2 setTitle:@"顺计时" forState:UIControlStateNormal];
    _button2.backgroundColor = [UIColor orangeColor];
    [_button2 addTarget:self action:@selector(timingTest2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_button2];
}

/** 计时测试1 倒计时 */
- (void)timingTest1 {
    
    [[FTTimerUtil instance] startTimingWithMaxtime:10 timingWay:TimingWayDown timingBlock:^(int recordTime) {
        [_button1 setTitle:[NSString stringWithFormat:@"%d S", recordTime] forState:UIControlStateNormal];
        _button1.enabled = NO;
        _button1.backgroundColor = [[UIColor orangeColor] colorWithAlphaComponent:0.7];
    } completeBlock:^{
        [_button1 setTitle:@"倒计时" forState:UIControlStateNormal];
        _button1.enabled = YES;
        _button1.backgroundColor = [UIColor orangeColor];
    }];
}

/** 计时测试2 顺计时 */
- (void)timingTest2 {
    
    [[FTTimerUtil instance] startTimingWithMaxtime:10 timingWay:TimingWayUp timingBlock:^(int recordTime) {
        [_button2 setTitle:[NSString stringWithFormat:@"%d S", recordTime] forState:UIControlStateNormal];
        _button2.enabled = NO;
        _button2.backgroundColor = [[UIColor orangeColor] colorWithAlphaComponent:0.7];
    } completeBlock:^{
        [_button2 setTitle:@"顺计时" forState:UIControlStateNormal];
        _button2.enabled = YES;
        _button2.backgroundColor = [UIColor orangeColor];
    }];
}

@end

//
//  FTTimerUtil.m
//  StudyDemo
//
//  Created by xiaodou on 2016/10/27.
//  Copyright © 2016年 xiaodouxiaodou. All rights reserved.
//

#import "FTTimerUtil.h"

@interface FTTimerUtil ()
@property (nonatomic, strong) dispatch_source_t timer;  /**< 实际上为一个带指针结构体类型 所以用strong*/
@end

@implementation FTTimerUtil

+ (instancetype)instance {
//    static FTTimerUtil *timerUtil = nil;
//    
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        timerUtil = [[FTTimerUtil alloc] init];
//    });
//    return timerUtil;
    
    // 便于多个定时器同时调用 此处不用单例
    FTTimerUtil *timerUtil = [[FTTimerUtil alloc] init];
    return timerUtil;
}

/** 开始计时
 maxtime:       计时最大时间
 timingWay:     计时方式
 timingBlock:   正在计时回调
 completeBlock: 计时结束回调
 */
- (void)startTimingWithMaxtime:(int)maxtime
                     timingWay:(TimingWay)timingWay
                   timingBlock:(TimingBlock)timingBlock
                 completeBlock:(CompleteBlock)completeBlock {
    
    // GCD 定时器
    __block int recordTime = 0;
    if (timingWay == TimingWayDown) {
        recordTime = maxtime;
    }
    
    /** 1.创建GCD中的定时器
     第一个参数：source类型，DISPATCH_SOURCE_TYPE_TIMER 表示定时器
     第二个：描述信息，线程ID
     第三个：更详细的描述信息
     第四个：定时器任务的执行队列
     */
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
    
    /** 2.设置定时器
     timer不能为局部变量 局部变量执行一次后会被释放掉 要用全局变量
     第一个参数：定时器对象
     第二个：起始时间， DISPATCH_TIME_NOW表示从现在开始计时
     第三个：间隔时间  1.0表示每隔一秒触发一次 NSEC_PER_SEC为10的9次方（GCD的时间单位为纳秒）
     第四个：精准度(误差范围) 0表示绝对精准
     */
    dispatch_source_set_timer(self.timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    
    /** 3.设置定时器执行的任务（事件处理） timer若为局部变量则已被释放掉 任务不会执行 */
    dispatch_source_set_event_handler(self.timer, ^{
        // 此处为子线程
        //NSLog(@"GCD---%@", [NSThread currentThread]);
        
        // 常需要在主线程更新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            // 倒计时
            if (timingWay == TimingWayDown) {
                if (recordTime <= 0) {
                    dispatch_source_cancel(self.timer);
                    if (completeBlock) {
                        completeBlock();
                    }
                } else {
                    if (timingBlock) {
                        timingBlock(recordTime);
                    }
                    recordTime --;
                }
                
            } else {
                // 顺计时
                if (recordTime >= maxtime) {
                    dispatch_source_cancel(self.timer);
                    if (completeBlock) {
                        completeBlock();
                    }
                } else {
                    if (timingBlock) {
                        timingBlock(recordTime);
                    }
                    recordTime ++;
                }
            }
        });
    });
    
    /** 4.启动执行（重新开始） */
    dispatch_resume(self.timer);
}

/** 取消计时 */
- (void)cancelTiming {
    if (self.timer) {
        dispatch_source_cancel(self.timer);
    }
}

@end

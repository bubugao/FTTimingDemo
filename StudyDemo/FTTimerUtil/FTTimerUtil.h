//
//  FTTimerUtil.h
//  StudyDemo
//
//  Created by xiaodou on 2016/10/27.
//  Copyright © 2016年 xiaodouxiaodou. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^TimingBlock)(int recordTime);     /**< 正在计时 */
typedef void(^CompleteBlock)();                  /**< 计时结束 */

typedef NS_ENUM(NSInteger, TimingWay) {
    TimingWayDown,     /**< 倒计时 */
    TimingWayUp        /**< 顺计时 */
};

@interface FTTimerUtil : NSObject

+ (instancetype)instance;

/** 开始计时
 maxtime:       计时最大时间
 timingWay:     计时方式
 timingBlock:   正在计时回调
 completeBlock: 计时结束回调
 */
- (void)startTimingWithMaxtime:(int)maxtime
                     timingWay:(TimingWay)timingWay
                   timingBlock:(TimingBlock)timingBlock
                 completeBlock:(CompleteBlock)completeBlock;

/** 取消计时 */
- (void)cancelTiming;

@end

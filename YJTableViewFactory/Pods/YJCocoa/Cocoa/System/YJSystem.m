//
//  YJSystem.m
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/5/11.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YJSystem.h"

// 主线程运行
void dispatch_async_main(dispatch_block_t block) {
    dispatch_async(dispatch_get_main_queue(), block);
}

// 后台运行
void dispatch_async_background(dispatch_block_t block) {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    dispatch_async(queue, block);
}

// 异步UI执行
void dispatch_async_UI(dispatch_block_t block) {
    dispatch_async_background(^{
        dispatch_async_main(block);
    });
}

// 主线程延时执行
void dispatch_after_main(int64_t delayInSeconds, dispatch_block_t block) {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC)), dispatch_get_main_queue(), block);
}


@implementation YJSystem

@end

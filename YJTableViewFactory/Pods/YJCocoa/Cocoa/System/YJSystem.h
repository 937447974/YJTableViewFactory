//
//  YJSystem.h
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/5/11.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#ifdef __BLOCKS__

/** 主线程运行*/
void dispatch_async_main(dispatch_block_t block);

/** 后台运行*/
void dispatch_async_background(dispatch_block_t block);

/** 异步UI执行*/
void dispatch_async_UI(dispatch_block_t block);

/** 主线程延时执行*/
void dispatch_after_main(int64_t delayInSeconds, dispatch_block_t block);

#endif


/** System Framework*/
@interface YJSystem : NSObject

@end

NS_ASSUME_NONNULL_END

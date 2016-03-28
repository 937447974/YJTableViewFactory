//
//  YJTableViewDataSource.h
//  YJTableViewFactory
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by 阳君 on 16/3/26.
//  Copyright © 2016年 YJFactory. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "YJCellObject.h"
#import "UITableViewCell+YJTableViewFactory.h"

NS_ASSUME_NONNULL_BEGIN

/** 缓存Cell的策略*/
typedef NS_ENUM(NSInteger, YJTableViewCacheCell) {
    YJTableViewCacheCellDefault,  ///< 根据相同的UITableViewCell类名缓存Cell
    YJTableViewCacheCellIndexPath ///< 根据NSIndexPath对应的位置缓存Cell
};

/** UITableViewDataSource抽象接口*/
@interface YJTableViewDataSource : NSObject

@property (nonatomic, weak) UITableView *tableView; ///< tableView

@property (nonatomic) YJTableViewCacheCell cacheCellStrategy; ///< 缓存Cell的策略。无须赋值，YJTableViewDelegate会根据cacheHeightStrategy自动赋值

/**
 *  抽象的初始化接口
 *
 *  @param tableView UITableView
 *
 *  @return void
 */
- (instancetype)initWithTableView:(UITableView *)tableView;

/**
 *  根据cellObject创建UITableViewCell
 *
 *  @param cellObject YJCellObject
 *
 *  @return UITableViewCell
 */
- (UITableViewCell *)dequeueReusableCellWithCellObject:(YJCellObject *)cellObject;

@end

NS_ASSUME_NONNULL_END

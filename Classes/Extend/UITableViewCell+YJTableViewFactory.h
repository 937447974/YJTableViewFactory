//
//  UITableViewCell+YJTableViewFactory.h
//  YJTableViewFactory
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by 阳君 on 16/3/26.
//  Copyright © 2016年 YJFactory. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class YJCellObject, YJTableViewDelegate;


/** 点击cell的block*/
typedef void (^ YJTableViewCellBlock)(YJCellObject *cellObject, UITableViewCell  * __nullable tableViewCell);


/** 点击cell的协议*/
@protocol YJTableViewCellProtocol <NSObject>

/**
 *  用户点击Cell
 *
 *  @param cellObject    用户点击的cell数据
 *  @param tableViewCell 用户点击的Cell
 *
 *  @return void
 */
- (void)tableViewDidSelectCellWithCellObject:(YJCellObject *)cellObject tableViewCell:(nullable UITableViewCell *)cell;

@end



/** UITableViewCell扩展*/
@interface UITableViewCell (YJTableViewFactory)

/**
 *  获取cell的显示高。子类不实行时，会根据xib设置的高度自动计算高
 *
 *  @param cellObject cell封装的对象
 *
 *  @return CGFloat
 */
+ (CGFloat)tableView:(UITableView *)tableView heightForCellObject:(YJCellObject *)cellObject;

/**
 *  根据模型刷新Cell
 *
 *  @param cellObject        cell封装的对象
 *  @param tableViewDelegate YJTableViewDelegate
 *
 *  @return void
 */
- (void)reloadCellWithCellObject:(YJCellObject *)cellObject tableViewDelegate:(YJTableViewDelegate *)tableViewDelegate;

@end

NS_ASSUME_NONNULL_END

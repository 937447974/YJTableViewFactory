//
//  UITableViewCell+YJTableViewFactory.h
//  YJTableViewFactory
//
//  HomePage:https://github.com/937447974/YJTableViewFactory
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/3/26.
//  Copyright © 2016年 YJFactory. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJCellObject.h"

NS_ASSUME_NONNULL_BEGIN

@class YJTableViewDelegate;

/** UITableViewCell扩展*/
@interface UITableViewCell (YJTableViewFactory)

/*推荐存储数据的属性
@property (nonatomic, weak) YJCellObject *cellObject;
@property (nonatomic, weak) YJTableViewDelegate *tableViewDelegate;
*/

/**
 *  获取YJCellObject,子类重写可获取YJCellObject子类。
 *
 *  @return YJCellObject
 */
+ (id)cellObject;

/**
 *  获取YJCellObject并自动填充模型。
 *
 *  @param cellModel 对应的Cell模型
 *
 *  @return YJCellObject
 */
+ (id)cellObjectWithCellModel:(id<YJCellModelProtocol>)cellModel;

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

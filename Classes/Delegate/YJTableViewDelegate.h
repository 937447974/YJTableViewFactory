//
//  YJTableViewDelegate.h
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
#import "UITableViewCell+YJTableViewFactory.h"

NS_ASSUME_NONNULL_BEGIN

@class YJTableViewDataSource;


/** 缓存高的策略*/
typedef NS_ENUM(NSInteger, YJTableViewCacheHeight) {
    
    YJTableViewCacheHeightDefault,          ///< 根据相同的UITableViewCell类缓存高度
    YJTableViewCacheHeightIndexPath,        ///< 根据NSIndexPath对应的位置缓存高度
    YJTableViewCacheHeightClassAndIndexPath ///< 根据类名和NSIndexPath双重绑定缓存高度
    
};


/** UITableViewDelegate抽象接口*/
@interface YJTableViewDelegate : NSObject <UITableViewDelegate>

@property (nonatomic) BOOL isCacheHeight;                         ///< 是否缓存高，默认YES缓存，NO不缓存
@property (nonatomic) YJTableViewCacheHeight cacheHeightStrategy; ///< 缓存高的策略。无须赋值，YJTableViewDataSource抽象接口会根据cacheCellStrategy自动赋值

@property (nonatomic, weak, nullable) id <YJTableViewCellProtocol> cellDelegate; ///< 点击cell的代理
@property (nonatomic, copy, nullable) YJTableViewCellBlock cellBlock;            ///< 点击cell的block

/**
 *  初始化
 *
 *  @param dataSource YJTableViewDataSource数据源
 *
 *  @return YJTableViewDelegate
 */
- (instancetype)initWithDataSource:(YJTableViewDataSource *)dataSource;

/**
 *  UITableViewCell向VC发送数据
 *
 *  @param cellObject    用户点击的cell数据
 *  @param tableViewCell 用户点击的Cell
 *
 *  @return void
 */
- (void)sendVCWithCellObject:(YJCellObject *)cellObject tableViewCell:(nullable UITableViewCell *)cell;

/**
 *  清除所有缓存高
 *
 *  @return void
 */
- (void)clearAllCacheHeight;

/**
 *  根据cell的类清楚缓存高，cacheHeightStrategy = YJTableViewCacheHeightDefault
 *
 *  @param cellClass UITableViewCell类
 *
 *  @return void
 */
- (void)clearCacheHeightWithCellClass:(Class)cellClass;

/**
 *  根据NSIndexPath位置清除缓存高，cacheHeightStrategy = YJTableViewCacheHeightIndexPath
 *
 *  @param indexPath NSIndexPath
 *
 *  @return void
 */
- (void)clearCacheHeightWithIndexPath:(NSIndexPath *)indexPath;

/**
 *  根据NSIndexPath集合清除对应的缓存高，cacheHeightStrategy = YJTableViewCacheHeightIndexPath
 *
 *  @param indexPaths NSIndexPath集合
 *
 *  @return void
 */
- (void)clearCacheHeightWithIndexPaths:(NSArray<NSIndexPath *> *)indexPaths;

/**
 *  清除[startIndexPath,endIndexPath]的缓存高，cacheHeightStrategy = YJTableViewCacheHeightIndexPath
 *
 *  @param cellClass UITableViewCell类
 *
 *  @return void
 */
- (void)clearCacheHeightWithFromIndexPath:(NSIndexPath *)startIndexPath toIndexPath:(NSIndexPath *)endIndexPath;

@end

NS_ASSUME_NONNULL_END

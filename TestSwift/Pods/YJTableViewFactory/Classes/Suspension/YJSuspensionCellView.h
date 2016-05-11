//
//  YJSuspensionCellView.h
//  YJTableViewFactory
//
//  HomePage:https://github.com/937447974/YJTableViewFactory
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/5/11.
//  Copyright © 2016年 YJFactory. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class YJTableViewDelegate;

/** ///< 悬浮的cell层*/
@interface YJSuspensionCellView : UIView

@property (nonatomic, weak) YJTableViewDelegate *tableViewDelegate; ///< YJTableViewDelegate
@property (nonatomic) CGFloat contentOffsetY;                       ///< 偏移Y

/**
 *  添加悬浮Cell的位置
 *
 *  @param NSIndexPath indexPath
 *
 *  @return void
 */
- (void)addIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END

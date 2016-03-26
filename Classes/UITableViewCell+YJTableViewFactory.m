//
//  UITableViewCell+YJTableViewFactory.m
//  YJTableViewFactory
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by 阳君 on 16/3/26.
//  Copyright © 2016年 YJFactory. All rights reserved.
//

#import "UITableViewCell+YJTableViewFactory.h"

@implementation UITableViewCell (YJTableViewFactory)

+ (CGFloat)tableView:(UITableView *)tableView heightForCellObject:(YJCellObject *)cellObject {
    
    NSArray<UITableView *> *array = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:nil options:nil];
    if (array.count) {
        return CGRectGetHeight(array.firstObject.frame);
    } else {
        NSLog(@"请使用xib创建cell");
    }
    return tableView.rowHeight; // 默认高
}

- (void)reloadCellWithCellObject:(YJCellObject *)cellObject {
    
    NSLog(@"UITableViewCell子类%@请实现方法：%@", NSStringFromClass(self.class), NSStringFromSelector(_cmd));
    
}

@end

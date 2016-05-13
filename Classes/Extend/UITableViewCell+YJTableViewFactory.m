//
//  UITableViewCell+YJTableViewFactory.m
//  YJTableViewFactory
//
//  HomePage:https://github.com/937447974/YJTableViewFactory
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/3/26.
//  Copyright © 2016年 YJFactory. All rights reserved.
//

#import "UITableViewCell+YJTableViewFactory.h"
#import "YJTableViewDelegate.h"

@implementation UITableViewCell (YJTableViewFactory)

+ (id)cellObject {
    
    return [[YJTableCellObject alloc] initWithTableViewCellClass:self.class];
    
}

+ (id)cellObjectWithCellModel:(id<YJTableCellModelProtocol>)cellModel {
    
    YJTableCellObject *cellObject = [[YJTableCellObject alloc] initWithTableViewCellClass:self.class];
    cellObject.cellModel = cellModel;
    return cellObject;
    
}

+ (CGFloat)tableView:(UITableView *)tableView heightForCellObject:(YJTableCellObject *)cellObject {
    
    if (cellObject.createCell == YJTableViewCellCreateClass) {
        NSLog(@"自动获取高度时，UITableViewCell子类%@请实现方法：%@", YJStringFromClass(self.class), NSStringFromSelector(_cmd));
        return tableView.rowHeight; // 默认高
    }
    // soryboard方式创建cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:YJStringFromClass(self.class)];
    if (cell) {
        return CGRectGetHeight(cell.frame);
    }
    // xib创建cell
    NSArray<UITableView *> *array = [[NSBundle mainBundle] loadNibNamed:YJStringFromClass(self.class) owner:nil options:nil];
    return CGRectGetHeight(array.firstObject.frame);
    
}

- (void)reloadCellWithCellObject:(YJTableCellObject *)cellObject tableViewDelegate:(YJTableViewDelegate *)tableViewDelegate {
    
     NSLog(@"UITableViewCell子类%@请实现方法：%@", YJStringFromClass(self.class), NSStringFromSelector(_cmd));
    
}

@end

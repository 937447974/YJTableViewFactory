//
//  YJSuspensionCellView.m
//  YJTableViewFactory
//
//  HomePage:https://github.com/937447974/YJTableViewFactory
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/5/11.
//  Copyright © 2016年 YJFactory. All rights reserved.
//

#import "YJSuspensionCellView.h"
#import "YJTableViewDelegate.h"
#import "YJTableViewDataSource.h"

@implementation NSIndexPath (YJSuspensionCellView)

#pragma mark 较小
- (BOOL)lessThan:(NSIndexPath *)indexPath {
    if (self.section < indexPath.section) {
        return YES;
    } else if (self.row < indexPath.row) {
        return YES;
    }
    return NO;
}

#pragma mark 相等
- (BOOL)isEqual:(NSIndexPath *)indexPath {
    return self.section == indexPath.section && self.row == indexPath.row;
}

@end

#pragma mark - YJSuspensionCellView
@interface YJSuspensionCellView () {
    CGFloat _baseY; ///< 基点,-1未初始化
}

@property (nonatomic, weak) UITableView *tableView; ///< UITableView
@property (nonatomic, strong) NSMutableArray<NSIndexPath *> *indexPaths; ///< 悬浮的cell位置

@end

@implementation YJSuspensionCellView

#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame {
    frame.size.height = 0;
    self = [super initWithFrame:frame];
    if (self) {
        _baseY = -1;
    }
    return self;
}

#pragma mark - 添加indexPath
- (void)addIndexPath:(NSIndexPath *)indexPath {
    
    for (NSInteger i = 0; i < self.indexPaths.count; i++) {
        NSIndexPath *index = [self.indexPaths objectAtIndex:i];
        if ([indexPath lessThan:index]) {
            [self.indexPaths insertObject:indexPath atIndex:i];
            return;
        } else if ([index isEqual:indexPath]) {
            return;
        }
    }
    [self.indexPaths addObject:indexPath];
}

#pragma mark - setter and getter
- (UITableView *)tableView {
    return self.tableViewDelegate.dataSource.tableView;
}

- (NSMutableArray<NSIndexPath *> *)indexPaths {
    if (!_indexPaths) {
        _indexPaths = [NSMutableArray array];
    }
    return _indexPaths;
}

- (void)setContentOffsetY:(CGFloat)contentOffsetY {
    _baseY = _baseY == -1 ? contentOffsetY : _baseY;
    _contentOffsetY = contentOffsetY;
    NSLog(@"%f", _contentOffsetY);
    NSLog(@"%f", _baseY);
    /*
    
    static NSString *c ;
    if (!c) {
        c = @"11";
        self.dataSource.tableView
    }
    NSIndexPath *ip = [NSIndexPath indexPathForRow:1 inSection:0];
    static UITableViewCell *cell;
    CGRect rect = [self.dataSource.tableView rectForRowAtIndexPath:ip];
    if (cell == nil) {
        cell = [self.dataSource tableView:self.dataSource.tableView cellForRowAtIndexPath:ip];
        [self.dataSource.tableView.superview addSubview:cell];
        [cell setNeedsUpdateConstraints];
    }
    CGRect cr = cell.frame;
    cr.size = rect.size;
    CGPoint contentOffset = scrollView.contentOffset;
    NSLog(@"%@", NSStringFromCGPoint(contentOffset));
    NSLog(@"%@", NSStringFromCGRect([self.dataSource.tableView rectForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]]));
    if (contentOffset.y > rect.origin.y + rect.size.height) {
        cr.origin.y = self.dataSource.tableView.frame.origin.y;
        cell.frame = cr;
        NSLog(@"持续显示");
    } else if (contentOffset.y > rect.origin.y) {
        NSLog(@"显示动画中");
        cr.origin.y = rect.origin.y - contentOffset.y+self.dataSource.tableView.frame.origin.y;
        cell.frame = cr;
    } else {
        [cell removeFromSuperview];
        cell = nil;
    }
    //    NSLog(@"%@",NSStringFromCGRect(rect));
    //    NSLog(@"%@",[self.dataSource tableView:self.dataSource.tableView cellForRowAtIndexPath:ip]);
    */
}



@end

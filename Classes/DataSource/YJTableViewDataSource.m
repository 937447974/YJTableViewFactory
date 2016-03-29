//
//  YJTableViewDataSource.m
//  YJTableViewFactory
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by 阳君 on 16/3/26.
//  Copyright © 2016年 YJFactory. All rights reserved.
//

#import "YJTableViewDataSource.h"
#import "YJTableViewDelegate.h"

@implementation YJTableViewDataSource

- (instancetype)initWithTableView:(UITableView *)tableView {
    
    self = [super init];
    if (self) {
        self.tableView = tableView;
    }
    return self;
    
}

- (UITableViewCell *)dequeueReusableCellWithCellObject:(YJCellObject *)cellObject{
    
    NSString *identifier = self.cacheCellStrategy == YJTableViewCacheCellDefault ? cellObject.cellName : [NSString stringWithFormat:@"%ld-%ld", cellObject.indexPath.section, cellObject.indexPath.row];
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        // 未找到时，重新注入，再寻找
        switch (cellObject.createCell) {
            case YJTableViewCellCreateDefault:
                [self.tableView registerNib:[UINib nibWithNibName:cellObject.cellName bundle:nil] forCellReuseIdentifier:identifier];
                 cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
                break;
                
            case YJTableViewCellCreateSoryboard:
                NSLog(@"Soryboard中请使用%@设置cell的Identifier属性", cellObject.cellName);
                break;
            case YJTableViewCellCreateClass:
                 cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
                break;
        }
    }
    [cell reloadCellWithCellObject:cellObject];
    return cell;
    
}

@end

//
//  YJFirstViewController.m
//  YJTableViewFactory
//
//  Created by admin on 16/3/26.
//  Copyright © 2016年 YJFactory. All rights reserved.
//

#import "YJFirstViewController.h"
#import "YJTableViewFactory.h"
#import "YJTableViewCell.h"

@interface YJFirstViewController () <YJTableViewCellProtocol>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

// 需要强引用
@property (nonatomic, strong) YJTableViewDataSourcePlain *dataSourcePlain;
@property (nonatomic, strong) YJTableViewDelegate *delegate;

@end

@implementation YJFirstViewController

- (void)viewDidLoad
{    
    [super viewDidLoad];
    
    self.dataSourcePlain = [[YJTableViewDataSourcePlain alloc] initWithTableView:self.tableView];
    self.delegate = [[YJTableViewDelegate alloc] initWithDataSource:self.dataSourcePlain];
    self.delegate.delegate = self;
    self.tableView.dataSource = self.dataSourcePlain;
    self.tableView.delegate = self.delegate;
    
    // 测试数据
    for (int i=0; i<20; i++) {
        // 封装模型
        YJTableViewCellModel *cellModel = [[YJTableViewCellModel alloc] init];
        cellModel.userName = [NSString stringWithFormat:@"阳君-%d", i];
        // 封装CellObject
        YJCellObject *cellObject = [[YJCellObject alloc] initWithTableViewCellClass:[YJTableViewCell class]];
        cellObject.cellModel = cellModel;
        // 填充数据源
        [self.dataSourcePlain.dataSource addObject:cellObject];
    }
    
}


#pragma mark - YJTableViewDelegateProtocol
- (void)tableViewDidSelectCellWithCellObject:(YJCellObject *)cellObject
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

@end

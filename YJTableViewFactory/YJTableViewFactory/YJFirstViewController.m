//
//  YJFirstViewController.m
//  YJTableViewFactory
//
//  Created by 阳君 on 16/3/26.
//  Copyright © 2016年 YJFactory. All rights reserved.
//

#import "YJFirstViewController.h"
#import "YJTableViewCell.h"

@interface YJFirstViewController () <YJTableViewCellProtocol>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

// 需要强引用
@property (nonatomic, strong) YJTableViewDataSourcePlain *dataSourcePlain;

@end

@implementation YJFirstViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
//    [self test1];
//    [self test2];
//    [self test3];
    [self test4];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self.dataSourcePlain scrollToCellObject:self.dataSourcePlain.dataSource.lastObject animated:YES];
//        [self.dataSourcePlain scrollToIndexPath:[NSIndexPath indexPathForRow:50 inSection:0]   animated:YES];
        [self.dataSourcePlain.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:100 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    });
    
}

#pragma mark - 测试数据
- (void)initTestData {
    
    // 测试数据
    for (int i=0; i<120; i++) {
        // 封装模型
        YJTableViewCellModel *cellModel = [[YJTableViewCellModel alloc] init];
        cellModel.userName = [NSString stringWithFormat:@"阳君-%d", i];
        // 封装CellObject
        YJCellObject *cellObject = [YJTableViewCell cellObjectWithCellModel:cellModel];
        // 填充数据源
        [self.dataSourcePlain.dataSource addObject:cellObject];
    }
    
}

#pragma mark - 使用默认的YJCellObject
- (void)test1 {
    
    self.dataSourcePlain = [[YJTableViewDataSourcePlain alloc] initWithTableView:self.tableView];
    [self initTestData];
   
}

#pragma mark - 使用自定义的YJTableViewCellObject
- (void)test2 {
    
    self.dataSourcePlain = [[YJTableViewDataSourcePlain alloc] initWithTableView:self.tableView];
    
    // 测试数据
    for (int i=0; i<20; i++) {
        // 封装模型
        YJTableViewCellModel *cellModel = [[YJTableViewCellModel alloc] init];
        cellModel.userName = [NSString stringWithFormat:@"阳君-%d", i];
        // 封装CellObject
        YJTableViewCellObject *cellObject = [[YJTableViewCellObject alloc] init];
        cellObject.cellModel = cellModel;
        // 填充数据源
        [self.dataSourcePlain.dataSource addObject:cellObject];
    }
    
}

#pragma mark - 通过协议监听点击dell
- (void)test3 {
    
    self.dataSourcePlain = [[YJTableViewDataSourcePlain alloc] initWithTableView:self.tableView];
    self.dataSourcePlain.tableViewDelegate.cellDelegate = self;
    [self initTestData];
    
}

#pragma mark YJTableViewDelegateProtocol
- (void)tableViewDidSelectCellWithCellObject:(YJCellObject *)cellObject tableViewCell:(UITableViewCell *)cell {
    
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
}

#pragma mark - 通过block监听点击dell
- (void)test4 {
    
    self.dataSourcePlain = [[YJTableViewDataSourcePlain alloc] initWithTableView:self.tableView];
    self.dataSourcePlain.tableViewDelegate.cellBlock = ^(YJCellObject *cellObject, UITableViewCell *tableViewCell) {
        NSLog(@"%@", cellObject.indexPath);
    };
    [self initTestData];
    
}

@end

//
//  YJSecondViewController.m
//  YJTableViewFactory
//
//  Created by admin on 16/3/26.
//  Copyright © 2016年 YJFactory. All rights reserved.
//

#import "YJSecondViewController.h"
#import "YJTableViewFactory.h"

@interface YJSecondViewController () <UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

// 需要强引用
@property (nonatomic, strong) YJTableViewDataSourcePlain *dataSourcePlain;
@property (nonatomic, strong) YJTableViewDelegate *delegate;

@end

@implementation YJSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataSourcePlain = [[YJTableViewDataSourcePlain alloc] initWithTableView:self.tableView];
    self.delegate = [[YJTableViewDelegate alloc] initWithDataSource:self.dataSourcePlain];
    self.tableView.dataSource = self.dataSourcePlain;
    self.tableView.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

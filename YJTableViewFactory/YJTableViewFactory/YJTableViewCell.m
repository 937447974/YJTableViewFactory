//
//  YJTableViewCell.m
//  YJTableViewFactory
//
//  Created by 阳君 on 16/3/26.
//  Copyright © 2016年 YJFactory. All rights reserved.
//

#import "YJTableViewCell.h"

@implementation YJTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)reloadCellWithCellObject:(YJCellObject *)cellObject
{
    YJTableViewCellModel *celModel = cellObject.cellModel;
    self.textLabel.text = celModel.userName;
}

@end

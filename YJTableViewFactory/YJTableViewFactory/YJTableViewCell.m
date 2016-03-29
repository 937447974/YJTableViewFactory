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

- (void)reloadCellWithCellObject:(YJCellObject *)cellObject cellProtocol:(id<YJTableViewCellProtocol>)cellProtocol{
    
    YJTableViewCellModel *celModel = cellObject.cellModel;
    self.textLabel.text = celModel.userName;
    self.detailTextLabel.text = [NSString stringWithFormat:@"%ld-%ld", cellObject.indexPath.section, cellObject.indexPath.row];
    
}

@end

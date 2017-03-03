//
//  HYOrderCell.m
//  HYOrderDemo
//
//  Created by David on 2017/3/1.
//  Copyright © 2017年 GangZi. All rights reserved.
//

#import "HYOrderCell.h"

@implementation HYOrderCell


+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    static NSString *cID = @"cell";
    id cell = [tableView dequeueReusableCellWithIdentifier:cID];
    
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cID];
         
    }
    return cell;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

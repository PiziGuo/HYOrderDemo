//
//  HYTopButtonView.m
//  HYOrderDemo
//
//  Created by David on 2017/2/28.
//  Copyright © 2017年 GangZi. All rights reserved.
//

#import "HYTopButtonView.h"
#import "HYConst.h"

@interface HYTopButtonView ()

@property (nonatomic, strong)UILabel *bottom;

@end


@implementation HYTopButtonView


- (instancetype)initWithButtonArray:(NSArray *)buttonArray {
    
    if (self = [super init]) {
        self.frame = CGRectMake(0, 64, ScreenWidth, 44);
        self.buttonArray = buttonArray;
        [self initView];
    }
    return self;
}


- (void)initView {
    
    CGFloat buttonW = ScreenWidth / self.buttonArray.count;
    CGFloat buttonH = 42;
    for (int i = 0; i < self.buttonArray.count; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:self.buttonArray[i] forState:UIControlStateNormal];
        if (i == 0) {
            button.selected = YES;
        }
        [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        button.tag = i;
        button.frame = CGRectMake(i * buttonW, 0, buttonW, buttonH);
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
    
    
    NSString *title = self.buttonArray[0];
    
    CGRect rect = [title boundingRectWithSize:CGSizeMake(100, 100) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
    self.bottom = [[UILabel alloc] initWithFrame:CGRectMake((buttonW - rect.size.width) / 2, buttonH, rect.size.width, 2)];
    self.bottom.backgroundColor = [UIColor redColor];
    [self addSubview:self.bottom];
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 43.5, ScreenWidth, 0.5)];
    line.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self addSubview:line];
    
}

- (void)buttonClicked:(UIButton *)sender {
    for (UIButton *view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            view.selected = NO;
        }
    }
    sender.selected = !sender.selected;
    [sender setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    
    CGFloat buttonW = ScreenWidth / self.buttonArray.count;
    CGFloat buttonH = 42;
    CGRect rect = [sender.titleLabel.text boundingRectWithSize:CGSizeMake(100, 100) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
    [UIView animateWithDuration:0.2 animations:^{
        self.bottom.frame = CGRectMake(sender.tag * buttonW + sender.titleLabel.frame.origin.x, buttonH, rect.size.width, 2);
    }];
    
    if (self.orderListChooseBlock) {
        self.orderListChooseBlock(sender.tag);
    }
}






@end

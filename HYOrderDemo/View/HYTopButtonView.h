//
//  HYTopButtonView.h
//  HYOrderDemo
//
//  Created by David on 2017/2/28.
//  Copyright © 2017年 GangZi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^orderListChooseBlock) (NSInteger btnTag);

@interface HYTopButtonView : UIView

- (instancetype)initWithButtonArray:(NSArray *)buttonArray;

@property (nonatomic, copy) orderListChooseBlock orderListChooseBlock;


@property (nonatomic, strong) NSArray *buttonArray;


@end

//
//  HYOrderController.m
//  HYOrderDemo
//
//  Created by David on 2017/2/28.
//  Copyright © 2017年 GangZi. All rights reserved.
//

#import "HYOrderController.h"
#import "HYTopButtonView.h"
#import "Masonry.h"
#import "HYConst.h"
#import "HYNetworkManager.h"

/**卖家
 0，所有订单
 1, 待确认
 2，等待买家付款
 3，待发货
 4，成功的订单
 5，待发货（智能发货订单）
 6，已发货
 */
typedef NS_ENUM(NSInteger, HYOrderBuyerRequestType) {
    
    HYOrderBuyerRequestAll = 0,
    HYOrderBuyerRequestWaitSure,
    HYOrderBuyerRequestWaitPay,
    HYOrderBuyerRequestWaitSend,
    HYOrderBuyerRequestSuccessed,
    HYOrderBuyerRequestWaitSendIntellgence,
    HYOrderBuyerRequestAlreadySend
    
};

typedef NS_ENUM(NSInteger, HYOrderUserRequestType) {
    
    HYOrderUserRequestAll = 0,
    HYOrderUserRequestWaitPay,
    HYOrderUserRequestWaitSend,
    HYOrderUserRequestWaitSure,
    HYOrderUserRequestSuccessed,
    HYOrderUserRequestClosed,
    HYOrderUserRequestDoing,
    HYOrderUserRequestAlreadySend
    
};


@interface HYOrderController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) HYTopButtonView *topButtonView;


@property (nonatomic, assign) HYOrderUserRequestType userRequestType;
@property (nonatomic, assign) HYOrderBuyerRequestType buyerRequestType;



@property (nonatomic, strong) NSString *buyerType;

// data
@property (nonatomic, strong) NSMutableArray *orderListArray;

@end

@implementation HYOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    
    [self initData];
}

- (void)initView {
    
    [self.view addSubview:self.topButtonView];
    [self.view addSubview:self.tableView];
    
    __weak typeof(self) weakSelf = self;
    [_topButtonView setOrderListChooseBlock:^(NSInteger btnTag) {
        
        __strong typeof(weakSelf)strongSelf = weakSelf;
        if ([strongSelf.buyerType isEqualToString:@"1"]) {
            
            switch (btnTag) {
                case 0:// 已付款
                {
                    strongSelf.userRequestType = HYOrderUserRequestWaitPay;
                }
                    break;
                case 1:// 待发货
                {
                    strongSelf.userRequestType = HYOrderUserRequestWaitSend;
                }
                    break;
                case 2:// 已发货
                {
                    strongSelf.userRequestType = HYOrderUserRequestAlreadySend;
                }
                    break;
                case 3:// 已完成
                {
                    strongSelf.userRequestType = HYOrderUserRequestSuccessed;
                }
                    break;
                case 4:// 全部
                {
                    strongSelf.userRequestType = HYOrderUserRequestAll;
                }
                    break;
                default:
                    break;
            }
            
            [strongSelf netForGetOrderListWithRequestType:strongSelf.userRequestType];
            
        } else {
            
            switch (btnTag) {
                case 0:
                {
                    strongSelf.buyerRequestType = HYOrderBuyerRequestWaitPay;
                }
                    break;
                case 1:
                {
                    strongSelf.buyerRequestType = HYOrderBuyerRequestWaitSend;
                }
                    break;
                case 2:
                {
                    strongSelf.buyerRequestType = HYOrderBuyerRequestAlreadySend;
                }
                    break;
                case 3:
                {
                    strongSelf.buyerRequestType = HYOrderBuyerRequestSuccessed;
                }
                    break;
                case 4:
                {
                    strongSelf.buyerRequestType = HYOrderBuyerRequestAll;
                }
                    break;
                default:
                    break;
            }
            [strongSelf netForGetOrderListWithRequestType:strongSelf.buyerRequestType];
        }
    }];
}



- (void)initData {
    
    NSArray *signArr = @[@"memberID",@"9A7E",@"page",@"1",@"pageSize",@"10",@"requestType",@"3"];
    
    NSDictionary *paramsDic = @{
                  @"memberID":@"9A7E",
                  @"page":@"1",
                  @"pageSize":@"10",
                  @"requestType":@"3",
                  };
    NSString *urlStr = @"Order/GetBuyerMyOrderList";
    HYNetworkManager *manager = [HYNetworkManager shareManager];
    
    [manager GETWithURLString:urlStr parameters:paramsDic signArray:signArr success:^(id response) {
        
        self.orderListArray = (NSMutableArray *)response;
        
        [self.tableView reloadData];
        NSLog(@"response-->%@",response);
        
    } failure:^(NSError *error) {
        
        NSLog(@"error-->%@",error);
        
    }];
}



#pragma mark - 

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.orderListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cID];
    }
    NSDictionary *orderDict = self.orderListArray[indexPath.row];
    cell.textLabel.text = orderDict[@"ProductName"];
    return cell;
}





#pragma mark - networking
- (void)netForGetOrderListWithRequestType:(int)requestType {
    
    NSString *requestTypeStr = [NSString stringWithFormat:@"%d",requestType];
    NSArray *signArr = @[@"memberID",@"9A7E",@"page",@"1",@"pageSize",@"10",@"requestType",requestTypeStr];
    
    NSDictionary *paramsDic = @{
                                @"memberID":@"9A7E",
                                @"page":@"1",
                                @"pageSize":@"10",
                                @"requestType":requestTypeStr,
                                };
    NSString *urlStr = @"Order/GetBuyerMyOrderList";
    HYNetworkManager *manager = [HYNetworkManager shareManager];
    manager.showHUD = YES;
    [manager GETWithURLString:urlStr parameters:paramsDic signArray:signArr success:^(id response) {
        
        self.orderListArray = (NSMutableArray *)response;
        
        [self.tableView reloadData];
        NSLog(@"response-->%@",response);
        
    } failure:^(NSError *error) {
        
        NSLog(@"error-->%@",error);
        
    }];
    
    
}


#pragma amrk - lazy initialize
-(HYTopButtonView *)topButtonView {
    if (!_topButtonView) {
        NSArray *buttonArray = @[@"已付款",@"待发货",@"已发货",@"已完成",@"全部"];
        _topButtonView = [[HYTopButtonView alloc] initWithButtonArray:buttonArray];
    }
    return _topButtonView;
}

-(UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavHeight + buttonViewHeight, ScreenWidth, ScreenHeight - NavHeight - buttonViewHeight) style:UITableViewStylePlain];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        
    }
    return _tableView;
}

#pragma mark - Other
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

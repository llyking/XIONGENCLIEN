//
//  FollowOrderDetailViewC.m
//  XIONGEN
//
//  Created by Ios on 2018/1/23.
//  Copyright © 2018年 Ios. All rights reserved.
//

#import "FollowOrderDetailViewC.h"
#import "OrderDetailModel.h"
#import "GoodsModel.h"
#import "OrderStatusModel.h"
#import "OrderDetailHeadView.h"
#import "FollowGoodsTableViewCell.h"
#import "DWQLogisticCell.h"

@interface FollowOrderDetailViewC () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) OrderDetailHeadView *headView;

@end

@implementation FollowOrderDetailViewC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.Namelab.text = @"订单详情";
    _dataSource = [[NSMutableArray alloc] init];
    [self selectOrderDetailByOrderNum];
}

-(void)loadViewWithOrderNum:(NSString *)order {
    
    if (!self.dataSource.count) {
        self.dataSource = [[NSMutableArray alloc] init];
    }
    
    self.orderNum = order;
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:order forKey:@"orderNum"];
    [dict setObject:FID forKey:@"sysUserId"];
    [self selectByOrderNumWithDict:dict];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self setFooterView];
    });
}

#pragma mark - 确认收货UI
-(void)setFooterView {
    UIView *footerV = [[UIView alloc] init];
    footerV.frame = CGRectMake(0, 0, kScreenWidth, 80);
    footerV.backgroundColor = WhiteColor;
    self.tableView.tableFooterView = footerV;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake((kScreenWidth-100)/2, 15, 100, 50);
    btn.backgroundColor = ThemeColor;
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [btn setTitleColor:WhiteColor forState:UIControlStateNormal];
    [btn setTitle:@"确认收货" forState:UIControlStateNormal];
    btn.titleLabel.font = LSYUIFont(13);
    btn.layer.cornerRadius = 6;
    btn.layer.masksToBounds = YES;
    [btn addTarget:self action:@selector(post) forControlEvents:UIControlEventTouchUpInside];
    [footerV addSubview:btn];
}

#pragma mark - 扫描后服务器返回的数据
-(void)selectByOrderNumWithDict:(NSMutableDictionary *)dict {
    [HttpRoadData postUpdateInfoInViewNo:self.view withVersionCode:[NSString stringWithFormat:@"%@%@",BaseURL,@"back/customerOrder/selectByOrderNum.do"] NSMutableDictionary:dict successBlock:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *parm = responseObject;
        if ([[NSString stringWithFormat:@"%@",parm[@"success"]] isEqualToString:@"1"] && [[NSString stringWithFormat:@"%@",parm[@"errcode"]] isEqualToString:@"0"]) {
            
            [self analysisWithData:parm[@"data"]];
            
        } else {
            [SVProgressHUD showErrorWithStatus:parm[@"message"]];
        }
        
    } failureBlock:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error:%@",error);
        [SVProgressHUD dismiss];
    }];
}

#pragma mark - 获取数据接口
-(void)selectOrderDetailByOrderNum {
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:self.orderNum,@"orderNum", nil];
    [HttpRoadData postUpdateInfoInViewNo:self.view withVersionCode:[NSString stringWithFormat:@"%@%@",BaseURL,@"back/customerOrder/selectOrderDetailByOrderNum.do"] NSMutableDictionary:dict successBlock:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *parm = responseObject;
        if ([[NSString stringWithFormat:@"%@",parm[@"success"]] isEqualToString:@"1"] && [[NSString stringWithFormat:@"%@",parm[@"errcode"]] isEqualToString:@"0"]) {
            [self analysisWithData:parm[@"data"]];
        } else {
            [SVProgressHUD showErrorWithStatus:parm[@"message"]];
        }
    } failureBlock:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error:%@",error);
        [SVProgressHUD dismiss];
    }];
    
}

-(void)analysisWithData:(NSDictionary *)data {
    OrderDetailModel *model = [[OrderDetailModel alloc] init];
    NSDictionary *dict = [data objectForKey:@"consignee"];
    model.fid = [[dict objectForKey:@"fid"] intValue];
    model.contact = [dict objectForKey:@"contact"];
    model.phone = [dict objectForKey:@"phone"];
    model.address = [dict objectForKey:@"address"];
    model.orderName = [dict objectForKey:@"orderName"];
    model.salesman = [dict objectForKey:@"salesman"];
    model.logisticName = [dict objectForKey:@"logisticName"];
    model.orderNumber = self.orderNum;
    
    [model.goods addObjectsFromArray:[GoodsModel mj_objectArrayWithKeyValuesArray:[data objectForKey:@"material"]]];
    [_dataSource addObject:model];
    
     [self createUIView];
    
    if (!_headView) {
        _headView = [[OrderDetailHeadView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 141)];
        _tableView.tableHeaderView = _headView;
        _headView.model = model;
    }
}

#pragma mark -UI
-(void)createUIView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight, kScreenWidth, kScreenHeight-SafeAreaTopHeight-SafeAreaBottomHeight)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        [self.view addSubview:_tableView];
    }
}

#pragma mark - tableView delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    OrderDetailModel *model = _dataSource[section];
    return model.goods.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 115;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    OrderDetailModel *model = _dataSource[indexPath.section];
    FollowGoodsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"goodscell"];
    if (cell == nil) {
        cell = [[FollowGoodsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"goodscell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.gm = model.goods[indexPath.row];
    
    return cell;
}

#pragma mark -确认收货
-(void)post {
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:self.orderNum,@"orderNum", nil];
    [HttpRoadData postUpdateInfoInViewNo:self.view withVersionCode:[NSString stringWithFormat:@"%@%@",BaseURL,@"back/customerOrder/updateOrderStatusByOrderNum.do"] NSMutableDictionary:dict successBlock:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *parm = responseObject;
        if ([[NSString stringWithFormat:@"%@",parm[@"success"]] isEqualToString:@"1"] && [[NSString stringWithFormat:@"%@",parm[@"errcode"]] isEqualToString:@"0"]) {
            
            [SVProgressHUD showSuccessWithStatus:parm[@"message"]];
            
        } else {
            [SVProgressHUD showErrorWithStatus:parm[@"message"]];
        }
        
        
    } failureBlock:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error:%@",error);
        [SVProgressHUD dismiss];
    }];
}

@end

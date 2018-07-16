//
//  MyOrderReturnViewController.m
//  XIONGEN
//
//  Created by Ios on 2018/1/23.
//  Copyright © 2018年 Ios. All rights reserved.
//

#import "MyOrderReturnViewController.h"
#import "FollowOrderDetailViewC.h"
#import "FollowOrderTableViewCell.h"

@interface MyOrderReturnViewController () <UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) NSMutableArray *datasource;
@property (nonatomic,strong) LeftImageTextField *searchTF;

@end

@implementation MyOrderReturnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //待收货
    _datasource = [[NSMutableArray alloc] init];
    [self setSearchView];
    [self setUIView];
    [self getOrderByCustomerId];
}

-(void)getOrderByCustomerId {
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:USERID,@"customerId", nil];
    [HttpRoadData postUpdateInfoInViewNo:self.view withVersionCode:[NSString stringWithFormat:@"%@%@",BaseURL,@"back/customerOrder/getOrderByCustomerId.do"] NSMutableDictionary:dict successBlock:^(NSURLSessionDataTask *task, id responseObject) {
        
        [SVProgressHUD dismiss];
        NSDictionary *parm = responseObject;
        if ([[NSString stringWithFormat:@"%@",parm[@"success"]] isEqualToString:@"1"] && [[NSString stringWithFormat:@"%@",parm[@"errcode"]] isEqualToString:@"0"]) {
            
            [self analysisWithData:parm[@"data"]];
        }
        
    } failureBlock:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error:%@",error);
        [SVProgressHUD dismiss];
    }];
}

-(void)analysisWithData:(NSArray *)data {
    
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    [arr addObjectsFromArray:[OrderStatusModel mj_objectArrayWithKeyValuesArray:data]];
    
    for (int i=0; i<arr.count; i++) {
        OrderStatusModel *model = [arr objectAtIndex:i];
        if (model.order_status==4) {
            [_datasource addObject:model];
        }
    }
    
    [_table reloadData];
}

//搜索框
-(void)setSearchView {
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 45)];
    headView.backgroundColor = UIColorFromRGB(0xeeeeee);
    
    _searchTF = [[LeftImageTextField alloc] initWithFrame:CGRectMake(mergin_left, 5, kScreenWidth-2*mergin_left, 35) Placehold:@"请输入关键字进行搜索" andLeftImageName:@"search@2x"];
    _searchTF.backgroundColor = WhiteColor;
    _searchTF.textColor = UIColorFromRGB(0x333333);
    _searchTF.font = LSYUIFont(15);
    _searchTF.searchIcon.frame = CGRectMake(0, 0, 25, 25                                                                                                                                                                                             );
    [headView addSubview:_searchTF];
    
    [self.view addSubview:headView];
}

-(void)setUIView {
    
    if (!_table) {
        _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 45, kScreenWidth, kScreenHeight-SafeAreaTopHeight-SafeAreaBottomHeight-95)];
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        _table.delegate = self;
        _table.dataSource = self;
        _table.showsVerticalScrollIndicator = NO;
        [self.view addSubview:_table];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _datasource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FollowOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"orderreturn"];
    if (cell==nil) {
        cell = [[FollowOrderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"orderreturn"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.statuM = _datasource[indexPath.row];
    cell.btn_orderType.tag = indexPath.row;
    cell.btn_orderType.backgroundColor = ThemeColor;
    [cell.btn_orderType setTitleColor:WhiteColor forState:UIControlStateNormal];
    [cell.btn_orderType setTitle:@"确认收货" forState:UIControlStateNormal];
    cell.btn_orderType.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [cell.btn_orderType addTarget:self action:@selector(confirmRecipe:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    OrderStatusModel *model = [_datasource objectAtIndex:indexPath.row];
    FollowOrderDetailViewC *detail = [[FollowOrderDetailViewC alloc] init];
    detail.orderNum = model.order_num;
    [self.navigationController pushViewController:detail animated:YES];
}

#pragma mark -确认收货
-(void)confirmRecipe:(UIButton *)butn {
    OrderStatusModel *model = _datasource[butn.tag];
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:model.order_num,@"orderNum", nil];
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

#pragma mark --UITextField delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    _searchTF.text = @"";
    return YES;
}


@end

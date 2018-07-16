//
//  MyOrderAllViewController.m
//  XIONGEN
//
//  Created by Ios on 2018/1/23.
//  Copyright © 2018年 Ios. All rights reserved.
//

#import "MyOrderAllViewController.h"
#import "FollowOrderDetailViewC.h"
#import "FollowOrderTableViewCell.h"
#import "OrderStatusModel.h"
#import "OrderDetailModel.h"

@interface MyOrderAllViewController () <UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) NSMutableArray *datasource;
@property (nonatomic,strong) LeftImageTextField *searchTF;

@end

@implementation MyOrderAllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.datasource = [[NSMutableArray alloc] init];
    [self setSearchView];
    [self setUIView];
    [self getOrderByCustomerId];
}

-(void)getOrderByCustomerId {
    
    [SVProgressHUD showWithStatus:@"数据加载..."];
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:USERID,@"customerId", nil];
    [HttpRoadData postUpdateInfoInViewNo:self.view withVersionCode:[NSString stringWithFormat:@"%@%@",BaseURL,@"back/customerOrder/getOrderByCustomerId.do"] NSMutableDictionary:dict successBlock:^(NSURLSessionDataTask *task, id responseObject) {
        
        [SVProgressHUD dismiss];
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

-(void)analysisWithData:(NSArray *)data {
    
    [_datasource addObjectsFromArray:[OrderStatusModel mj_objectArrayWithKeyValuesArray:data]];
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
    FollowOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"orderall"];
    if (cell==nil) {
        cell = [[FollowOrderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"orderall"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.btn_orderType.backgroundColor = [UIColor clearColor];
    [cell.btn_orderType setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
    
    OrderStatusModel *model = _datasource[indexPath.row];
    cell.statuM = model;
    switch (model.order_status) {
        case 0:
            [cell.btn_orderType setTitle:@"待确认" forState:UIControlStateNormal];
            break;
        case 1:
            [cell.btn_orderType setTitle:@"已确认" forState:UIControlStateNormal];
            break;
        case 2:
            [cell.btn_orderType setTitle:@"待发货" forState:UIControlStateNormal];
            break;
        case 3:
            [cell.btn_orderType setTitle:@"待发货" forState:UIControlStateNormal];
            break;
        case 4:
            [cell.btn_orderType setTitle:@"确定收货" forState:UIControlStateNormal];
            break;
        case 5:
            [cell.btn_orderType setTitle:@"已收货" forState:UIControlStateNormal];
            break;
        case 6:
            [cell.btn_orderType setTitle:@"被驳回" forState:UIControlStateNormal];
            break;
        case 7:
            [cell.btn_orderType setTitle:@"待发货" forState:UIControlStateNormal];
            break;
        case 8:
            [cell.btn_orderType setTitle:@"待发货" forState:UIControlStateNormal];
            break;
        case 9:
            [cell.btn_orderType setTitle:@"待发货" forState:UIControlStateNormal];
            break;
        default:
            break;
    }
    
    cell.btn_orderType.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    OrderStatusModel *model = [_datasource objectAtIndex:indexPath.row];
    FollowOrderDetailViewC *detail = [[FollowOrderDetailViewC alloc] init];
    detail.orderNum = model.order_num;
    [self.navigationController pushViewController:detail animated:YES];
}

#pragma mark --UITextField delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    _searchTF.text = @"";
    return YES;
}






@end

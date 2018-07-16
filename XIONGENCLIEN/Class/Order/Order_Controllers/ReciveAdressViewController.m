//
//  ReciveAdressViewController.m
//  XIONGENCLIEN
//
//  Created by Ios on 2018/3/21.
//  Copyright © 2018年 Ios. All rights reserved.
//

#import "ReciveAdressViewController.h"
#import "ReciveAdressCell.h"

@interface ReciveAdressViewController () <UITableViewDelegate,UITableViewDataSource>

{
    ReciveAdressModel *_model;
}

@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) NSMutableArray *dataArray;

@end

@implementation ReciveAdressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.Namelab.text = @"选择收货地址";
    _dataArray = [[NSMutableArray alloc] init];
    [self createUI];
    [self getAddress];
}

#pragma mark - 接口数据
//收货地址
-(void)getAddress {
    
    [SVProgressHUD showWithStatus:@"数据加载..."];
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:USERID,@"customerid", nil];
    [HttpRoadData postUpdateInfoInViewNo:self.view withVersionCode:[NSString stringWithFormat:@"%@%@",BaseURL,@"back/basis/api/getAddress.do"] NSMutableDictionary:dict successBlock:^(NSURLSessionDataTask *task, id responseObject) {
        
        [SVProgressHUD dismiss];
        NSDictionary *parm = responseObject;
        if ([[NSString stringWithFormat:@"%@",parm[@"success"]] isEqualToString:@"1"] && [[NSString stringWithFormat:@"%@",parm[@"errcode"]] isEqualToString:@"0"]) {
            
            [self getLogisticsQueryWithData:parm[@"data"]];
            
        } else {
            [SVProgressHUD showErrorWithStatus:parm[@"message"]];
        }
        
    } failureBlock:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error:%@",error);
        [SVProgressHUD dismiss];
    }];
}

//物流公司
-(void)getLogisticsQueryWithData:(NSArray *)data {
    
    [HttpRoadData postUpdateInfoInViewNo:self.view withVersionCode:[NSString stringWithFormat:@"%@%@",BaseURL,@"back/basis/api/logisticsQuery.do"] NSMutableDictionary:nil successBlock:^(NSURLSessionDataTask *task, id responseObject) {
        [SVProgressHUD dismiss];
        NSDictionary *parm = responseObject;
        if ([[NSString stringWithFormat:@"%@",parm[@"success"]] isEqualToString:@"1"] && [[NSString stringWithFormat:@"%@",parm[@"errcode"]] isEqualToString:@"0"]) {
            
            [self analysisWithData:parm[@"data"] andAddressData:data];
        }

    } failureBlock:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error:%@",error);
        [SVProgressHUD dismiss];
    }];
}

-(void)analysisWithData:(NSArray *)logistData andAddressData:(NSArray *)addressData {
    
    [_dataArray addObjectsFromArray:[ReciveAdressModel mj_objectArrayWithKeyValuesArray:addressData]];
    
    for (int i=0; i<logistData.count; i++) {
        int fid = [[logistData[i] objectForKey:@"fid"] intValue];
        NSString *name = [[logistData objectAtIndex:i] objectForKey:@"name"];
        for (int j=0; j<_dataArray.count; j++) {
            ReciveAdressModel *model = [_dataArray objectAtIndex:j];
            if (fid==model.logisid&&model.logisCompany==nil&&![model.form isEqualToString:@"自提"]) {
                model.logisCompany = name;
            }
        }
    }
    [_table reloadData];
}


-(void)createUI {
    if (!_table) {
        _table = [[UITableView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight, kScreenWidth, kScreenHeight-SafeAreaTopHeight-SafeAreaBottomHeight)];
        _table.delegate = self;
        _table.dataSource = self;
        _table.tableFooterView = [[UIView alloc] init];
        [self.view addSubview:_table];
    }
    
    UIButton *cancle = [UIButton buttonWithType:UIButtonTypeCustom];
    cancle.frame = CGRectMake(0, kScreenHeight-SafeAreaBottomHeight-50, kScreenWidth/2, 50);
    cancle.backgroundColor = WhiteColor;
    [cancle setTitle:@"取消" forState:UIControlStateNormal];
    [cancle setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
    cancle.tag = 100;
    [cancle addTarget:self action:@selector(buttonTachuce:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancle];
    
    UIButton *sure = [UIButton buttonWithType:UIButtonTypeCustom];
    sure.frame = CGRectMake(CGRectGetMaxX(cancle.frame), kScreenHeight-SafeAreaBottomHeight-50, kScreenWidth/2, 50);
    sure.backgroundColor = ThemeColor;
    [sure setTitle:@"确定" forState:UIControlStateNormal];
    [sure setTitleColor:WhiteColor forState:UIControlStateNormal];
    sure.tag = 200;
    [sure addTarget:self action:@selector(buttonTachuce:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sure];
    
    UILabel *line = [[UILabel alloc] init];
    line.frame = CGRectMake(0, CGRectGetMinY(cancle.frame)-1, kScreenWidth, 1);
    line.backgroundColor = LineColor;
    [self.view addSubview:line];
}

#pragma mark -tableview delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ReciveAdressModel *model = _dataArray[indexPath.row];
    if (model.logisCompany) {
        return 105;
    }
    return 80;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ReciveAdressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reciveadress"];
    if (cell == nil) {
        cell = [[ReciveAdressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reciveadress"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.reAdMo = _dataArray[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ReciveAdressCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.img_select.image = [UIImage imageWithContentsOfFile:ImagePath(@"choose_sel@2x")];
    _model = _dataArray[indexPath.row];
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    ReciveAdressCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.img_select.image = [UIImage imageWithContentsOfFile:ImagePath(@"choose_nor@2x")];
}

-(void)buttonTachuce:(UIButton *)butn {
    if (butn.tag==100) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        if (self.adressBlock) {
            self.adressBlock(_model);
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}


@end

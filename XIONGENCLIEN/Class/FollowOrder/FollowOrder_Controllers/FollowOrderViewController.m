//
//  FollowOrderViewController.m
//  XIONGEN
//
//  Created by Ios on 2018/1/16.
//  Copyright © 2018年 Ios. All rights reserved.
//

#import "FollowOrderViewController.h"
#import "Drop_downButton.h"
#import "XEComboBox.h"
#import "FollowOrderTableViewCell.h"
#import "FollowOrderDetailViewC.h"
#import "MMScanViewController.h"

@interface FollowOrderViewController () <UITableViewDelegate,UITableViewDataSource>
{
    NSArray *comboBoxArr;
}

@property (nonatomic,strong) Drop_downButton *dropbtn;
@property (nonatomic,strong) LeftImageTextField *searchTF;
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) NSMutableArray *datasource;
@property (nonatomic,copy) NSString *type;

@end

@implementation FollowOrderViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.hidden = YES;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WhiteColor;
    
    _datasource = [[NSMutableArray alloc] init];
    [self setNavigationView];
    [self setUIView];
    [SVProgressHUD showWithStatus:@"数据加载..."];
    [self getOrderByCustomerId];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getOrderByCustomerId) name:@"RecivedGood" object:nil];
}


-(void)getOrderByCustomerId {
    
    [_datasource removeAllObjects];
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

-(void)setNavigationView {
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, SafeAreaTopHeight)];
    titleView.backgroundColor = ThemeColor;
    [self.view addSubview:titleView];
    
    UILabel *lb_title = [[UILabel alloc] init];
    lb_title.frame = CGRectMake(0, StatubarHeight, kScreenWidth, NavigtionHeight);
    lb_title.textColor = WhiteColor;
    lb_title.textAlignment = NSTextAlignmentCenter;
    lb_title.font = LSYUIFont(17);
    lb_title.text = @"收货";
    [titleView addSubview:lb_title];
    
    UIButton *dropbtn = [[UIButton alloc] initWithFrame:CGRectMake(mergin_left, StatubarHeight+(NavigtionHeight-30)/2, 30, 30)];
    [dropbtn setImage:[UIImage imageWithContentsOfFile:ImagePath(@"home_icon_cord@2x")] forState:UIControlStateNormal];
    dropbtn.adjustsImageWhenHighlighted = NO;
    [dropbtn addTarget:self action:@selector(chooseTitle) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:dropbtn];
    
}

-(void)setUIView {
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight, kScreenWidth, 45)];
    headView.backgroundColor = UIColorFromRGB(0xeeeeee);
    [self.view addSubview:headView];
    
    _searchTF = [[LeftImageTextField alloc] initWithFrame:CGRectMake(mergin_left, 5, kScreenWidth-2*mergin_left, 35) Placehold:@"请输入关键字进行搜索" andLeftImageName:@"search@2x"];
    _searchTF.backgroundColor = WhiteColor;
    _searchTF.textColor = UIColorFromRGB(0x333333);
    _searchTF.font = LSYUIFont(15);
    _searchTF.searchIcon.frame = CGRectMake(0, 0, 25, 25                                                                                                                                                                                             );
    [headView addSubview:_searchTF];
    
    if (!_table) {
        _table = [[UITableView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight+50, kScreenWidth, kScreenHeight-SafeAreaTopHeight-TabbarHeight-50)];
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        _table.delegate = self;
        _table.dataSource = self;
        _table.showsVerticalScrollIndicator = NO;
        [self.view addSubview:_table];
    }
}

#pragma mark -tableview delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _datasource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FollowOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"followorder"];
    if (cell==nil) {
        cell = [[FollowOrderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"followorder"];
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


-(void)chooseTitle {
    WS(weakSelf)
    //扫描
    MMScanViewController *scanVc = [[MMScanViewController alloc] initWithQrType:MMScanTypeQrCode onFinish:^(NSString *result, NSError *error) {
        if (error) {
            NSLog(@"error: %@",error);
        } else {
            NSLog(@"扫描结果：%@",result);
            [weakSelf showInfo:result];
        }
    }];
    [weakSelf.navigationController pushViewController:scanVc animated:YES];
}

#pragma mark - Error handle 扫描错误提示
- (void)showInfo:(NSString*)str {
//    [self showInfo:str andTitle:@"提示"];
    
    FollowOrderDetailViewC *detail = [[FollowOrderDetailViewC alloc] init];
    [detail loadViewWithOrderNum:str];
    [self.navigationController pushViewController:detail animated:YES];
}


- (void)showInfo:(NSString*)str andTitle:(NSString *)title {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:str preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = ({
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:NULL];
        action;
    });
    [alert addAction:action1];
    [self presentViewController:alert animated:YES completion:NULL];
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"RecivedGood" object:nil];
}


@end

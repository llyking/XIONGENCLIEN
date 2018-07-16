//
//  ScanViewController.m
//  XIONGEN
//
//  Created by Ios on 2018/1/22.
//  Copyright © 2018年 Ios. All rights reserved.
//

#import "ScanViewController.h"
#import "XE_ScanResultHeadView.h"
#import "XEScanResultTableViewCell.h"

@interface ScanViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) XE_ScanResultHeadView *headV;
@property (nonatomic,strong) UITextField *checkCodeTF;
@property (nonatomic,strong) UITableView *tableV;

@end

@implementation ScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.Namelab.text = @"扫码收件";
    [self creatui];
}

-(void)creatui {
    
    if (!_tableV) {
        _tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight, kScreenWidth, kScreenHeight-SafeAreaTopHeight-SafeAreaBottomHeight)];
        _tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableV.delegate = self;
        _tableV.dataSource = self;
        _tableV.showsVerticalScrollIndicator = NO;
        [self.view addSubview:_tableV];
        
        [self setTableViewHeadViewAndFooterView];
    }
    
}

//搜索框
-(void)setTableViewHeadViewAndFooterView {
    if (!_headV) {
        _headV = [[XE_ScanResultHeadView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 120)];
        _headV.lb_orderNumber.text = @"订单号:123456";
        _headV.lb_custom.text = @"客户:小明";
        _headV.lb_phone.text = @"电话:13584569851";
        _headV.lb_address.text = @"地址:广州天河";
        _headV.lb_salemen.text = @"业务员:小米";
        _headV.lb_orderMan.text = @"下单人:阿里";
        _tableV.tableHeaderView = _headV;
    }
    
    UIView *footerV = [[UIView alloc] init];
    footerV.backgroundColor = WhiteColor;
    footerV.frame = CGRectMake(0, 0, kScreenWidth, 220);
    _tableV.tableFooterView = footerV;
    
    UILabel *line = [[UILabel alloc] init];
    line.frame = CGRectMake(0, 0, kScreenWidth, 1);
    line.backgroundColor = LineColor;
    [footerV addSubview:line];
    
    _checkCodeTF = [[UITextField alloc] init];
    _checkCodeTF.frame = CGRectMake(50, 50, kScreenWidth-100, 40);
    _checkCodeTF.backgroundColor = WhiteColor;
    _checkCodeTF.textColor = UIColorFromRGB(0x333333);
    _checkCodeTF.font = LSYUIFont(13);
    _checkCodeTF.textAlignment = NSTextAlignmentLeft;
    _checkCodeTF.layer.borderColor = LineColor.CGColor;
    _checkCodeTF.layer.borderWidth = 1.0f;
    _checkCodeTF.layer.cornerRadius = 4;
    _checkCodeTF.layer.masksToBounds = YES;
    _checkCodeTF.placeholder = @"请输入确认码";
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
    leftView.backgroundColor = [UIColor whiteColor];
    _checkCodeTF.leftView = leftView;
    _checkCodeTF.leftViewMode = UITextFieldViewModeAlways;
    [footerV addSubview:_checkCodeTF];
    
    UIButton *post = [UIButton buttonWithType:UIButtonTypeCustom];
    post.frame = CGRectMake((kScreenWidth-200)/2, CGRectGetMaxY(_checkCodeTF.frame)+50, 200, 40);
    post.backgroundColor = ThemeColor;
    post.layer.cornerRadius = 4;
    post.layer.masksToBounds = YES;
    [post setTitle:@"确认签收" forState:UIControlStateNormal];
    post.titleLabel.font = LSYUIFont(17);
    post.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [post setTitleColor:WhiteColor forState:UIControlStateNormal];
    [post addTarget:self action:@selector(checkAction) forControlEvents:UIControlEventTouchUpInside];
    [footerV addSubview:post];
}

#pragma mark -tableView delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 115;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XEScanResultTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell==nil) {
        cell = [[XEScanResultTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

//签收
-(void)checkAction {
    
}



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

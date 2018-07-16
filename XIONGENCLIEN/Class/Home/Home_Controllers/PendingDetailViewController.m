//
//  PendingDetailViewController.m
//  XIONGEN
//
//  Created by Ios on 2018/1/22.
//  Copyright © 2018年 Ios. All rights reserved.
//

#import "PendingDetailViewController.h"

@interface PendingDetailViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITextView *opinionTF;
@property (nonatomic,strong) UILabel *lb_top;
@property (nonatomic,strong) UITableView *tableV;

@end

@implementation PendingDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.Namelab.text = @"待审批详情";
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
 
    UIView *headV = [[UIView alloc] init];
    headV.backgroundColor = WhiteColor;
    headV.frame = CGRectMake(0, 0, kScreenWidth, 40);
    _tableV.tableHeaderView = headV;
    
    UILabel *linet = [[UILabel alloc] init];
    linet.frame = CGRectMake(0, 40, kScreenWidth, 1);
    linet.backgroundColor = LineColor;
    [headV addSubview:linet];
    
    _lb_top = [[UILabel alloc] init];
    _lb_top.frame = CGRectMake(mergin_left, 10, kScreenWidth-2*mergin_left, 20);
    _lb_top.textColor = UIColorFromRGB(0x333333);
    _lb_top.font = LSYUIFont(15);
    _lb_top.textAlignment = NSTextAlignmentLeft;
    _lb_top.text = @"标题";
    [headV addSubview:_lb_top];
    
    UIView *footerV = [[UIView alloc] init];
    footerV.backgroundColor = WhiteColor;
    footerV.frame = CGRectMake(0, 0, kScreenWidth, 280);
    _tableV.tableFooterView = footerV;
    
    UILabel *line = [[UILabel alloc] init];
    line.frame = CGRectMake(0, 0, kScreenWidth, 1);
    line.backgroundColor = LineColor;
    [footerV addSubview:line];
    
    _opinionTF = [[UITextView alloc] init];
    _opinionTF.frame = CGRectMake(50, 50, kScreenWidth-100, 100);
    _opinionTF.backgroundColor = WhiteColor;
    _opinionTF.textColor = UIColorFromRGB(0x333333);
    _opinionTF.font = LSYUIFont(13);
    _opinionTF.textAlignment = NSTextAlignmentLeft;
    _opinionTF.layer.borderColor = LineColor.CGColor;
    _opinionTF.layer.borderWidth = 1.0f;
    _opinionTF.layer.cornerRadius = 4;
    _opinionTF.layer.masksToBounds = YES;
    [footerV addSubview:_opinionTF];
    
    UIButton *post = [UIButton buttonWithType:UIButtonTypeCustom];
    post.frame = CGRectMake((kScreenWidth-kScreenWidth/3*2-50)/2, CGRectGetMaxY(_opinionTF.frame)+50, kScreenWidth/3, 40);
    post.backgroundColor = ThemeColor;
    post.layer.cornerRadius = 4;
    post.layer.masksToBounds = YES;
    [post setTitle:@"驳回" forState:UIControlStateNormal];
    post.titleLabel.font = LSYUIFont(17);
    post.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [post setTitleColor:WhiteColor forState:UIControlStateNormal];
    [post addTarget:self action:@selector(checkAction) forControlEvents:UIControlEventTouchUpInside];
    [footerV addSubview:post];
    
    UIButton *pass = [UIButton buttonWithType:UIButtonTypeCustom];
    pass.frame = CGRectMake(CGRectGetMaxX(post.frame)+50, CGRectGetMaxY(_opinionTF.frame)+50, kScreenWidth/3, 40);
    pass.backgroundColor = ThemeColor;
    pass.layer.cornerRadius = 4;
    pass.layer.masksToBounds = YES;
    [pass setTitle:@"通过" forState:UIControlStateNormal];
    pass.titleLabel.font = LSYUIFont(17);
    pass.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [pass setTitleColor:WhiteColor forState:UIControlStateNormal];
    [pass addTarget:self action:@selector(checkAction) forControlEvents:UIControlEventTouchUpInside];
    [footerV addSubview:pass];
}

#pragma mark -tableView delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pendCell"];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"pendCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = @"申请日期:2018-01-08";
    cell.textLabel.textColor = UIColorFromRGB(0x333333);
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    cell.textLabel.font = LSYUIFont(13);
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

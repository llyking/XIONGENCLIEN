//
//  PendViewController.m
//  XIONGEN
//
//  Created by Ios on 2018/1/22.
//  Copyright © 2018年 Ios. All rights reserved.
//

#import "PendViewController.h"
#import "PendingDetailViewController.h"
#import "XEComboBox.h"
#import "PendingTableViewCell.h"

@interface PendViewController () <UITableViewDelegate,UITableViewDataSource>
{
    NSArray *comboBoxArr;
}

@property (nonatomic,strong) UITextField *searchTF;
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) NSMutableArray *datasource;
@property (nonatomic,copy) NSString *type;

@end

@implementation PendViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.Namelab.text = @"待审批";
    WS(weakSelf)
    [self createRightBtnWithImageArray:@[@"my_icon_blue_dian@2x"] handle:^(NSInteger tag) {
        [weakSelf rightBtnClick];
    }];
    [self initData];
    [self setUIView];
}

-(void)initData {
    comboBoxArr = @[@"全部",@"管理员",@"业务员",@"财务员"];
    _datasource = [[NSMutableArray alloc] init];
}

-(void)setUIView {
   
    if (!_table) {
        _table = [[UITableView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight, kScreenWidth, kScreenHeight-SafeAreaTopHeight-SafeAreaBottomHeight)];
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        _table.delegate = self;
        _table.dataSource = self;
        _table.showsVerticalScrollIndicator = NO;
        [self.view addSubview:_table];
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 8;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 110;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PendingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pending"];
    if (cell==nil) {
        cell = [[PendingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"pending"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PendingDetailViewController *detail = [[PendingDetailViewController alloc] init];
    [self.navigationController pushViewController:detail animated:YES];
}


-(void)rightBtnClick {
    
    XEComboBox  *comboBox = [XEComboBox shareXEComboBox];
    [comboBox initXEComboBoxWithDataArray:comboBoxArr andFrame:CGRectMake(0, 0, 100,40*comboBoxArr.count) isAnimation:YES];
    
    WS(weakSelf)
    [comboBox setXEFollowOrderStatusBack:^(NSString *type) {
        weakSelf.type = type;
        NSLog(@"%@",type);
    }];

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

//
//  MessageViewController.m
//  XIONGEN
//
//  Created by Ios on 2018/1/22.
//  Copyright © 2018年 Ios. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageModel.h"
#import "XEMessageTableViewCell.h"
#import "MessageDetailViewController.h"

@interface MessageViewController () <UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>

{
    UIButton*tembtn;
    NSMutableArray*btnArr;
    UIPageControl* page;
    CGRect temRect;
}

@property (nonatomic,strong) UIScrollView*Scrview1;
@property (nonatomic,strong) UIScrollView*Scrview2;
@property (nonatomic,strong) UITableView*tableview1;
@property (nonatomic,strong) UITableView*tableview2;
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,strong) NSMutableArray *dataSource1;

@end

@implementation MessageViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.Namelab.text = @"消息";
    btnArr = [[NSMutableArray alloc] init];
    _dataSource = [[NSMutableArray alloc] init];
    _dataSource1 = [[NSMutableArray alloc] init];
    temRect=CGRectZero;
    [self creatScrollview];
    [self creatTableview];
    [self getdata];
}

-(void)getdata {
    for (int i=0; i<10; i++) {
        MessageModel *message = [[MessageModel alloc] init];
        message.date = @"2018-01-20";
        if (i%2==0) {
            message.type = 1;
            message.message = @"这是消息推送";
        } else {
            message.type = 0;
            message.image = @"";
        }
        [_dataSource addObject:message];
    }
    [_tableview1 reloadData];
    
    for (int i=0; i<10; i++) {
        MessageModel *message = [[MessageModel alloc] init];
        message.date = @"2018-01-20";
        if (i%2!=0) {
            message.type = 1;
            message.message = @"这是消息推送";
        } else {
            message.type = 0;
            message.image = @"";
        }
        [_dataSource1 addObject:message];
    }
    [_tableview2 reloadData];
}


-(void)creatTableview {
    _tableview1=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CGRectGetHeight(_Scrview2.frame)) style:UITableViewStylePlain];
    _tableview1.delegate=self;
    _tableview1.dataSource=self;
    
    _tableview2=[[UITableView alloc] initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, CGRectGetHeight(_Scrview2.frame)) style:UITableViewStylePlain];
    _tableview2.delegate=self;
    _tableview2.dataSource=self;
    
    [self.Scrview2 addSubview:_tableview1];
    [self.Scrview2 addSubview:_tableview2];
}

-(void)creatScrollview {
    
    NSArray*arr=@[@"未读",@"已读"];
    for (int i=0; i<2; i++) {
        UIButton*btn=[[UIButton alloc] initWithFrame:CGRectMake(i*kScreenWidth/2, SafeAreaTopHeight, kScreenWidth/2, 40)];
        
        btn.tag=i;
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        btn.titleLabel.font=[UIFont systemFontOfSize:14];
        [btnArr addObject:btn];
        if (i==0) {
            [btn setTitleColor:ThemeColor forState:UIControlStateNormal];
            tembtn=btn;
            temRect=btn.frame;
        }
        else
            [btn setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
        
        [btn addTarget:self action:@selector(btn_clicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        
    }
    _Scrview1=[[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(temRect), kScreenWidth/2, 2)];
    [self.view addSubview:_Scrview1];
    _Scrview1.backgroundColor=ThemeColor;
    _Scrview1.delegate=self;
    _Scrview1.contentSize=CGSizeMake(kScreenWidth*2, 2);
    _Scrview1.showsHorizontalScrollIndicator=NO;
    _Scrview1.showsVerticalScrollIndicator=NO;
    
    _Scrview2=[[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_Scrview1.frame),kScreenWidth , kScreenHeight-CGRectGetMaxY(_Scrview1.frame))];
    [self.view addSubview:_Scrview2];
    _Scrview2.delegate=self;
    page=[[UIPageControl alloc]initWithFrame:CGRectZero];
    page.numberOfPages=3;
    page.currentPage=0;
    _Scrview2.pagingEnabled=YES;
    [_Scrview2 addSubview:page];
    _Scrview2.showsHorizontalScrollIndicator=NO;
    _Scrview2.showsVerticalScrollIndicator=NO;
    _Scrview2.contentSize=CGSizeMake(kScreenWidth*2,kScreenHeight/2);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView==_tableview1) {
        return _dataSource.count;
    }
    
    if (tableView==_tableview2) {
        return _dataSource1.count;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageModel *model;
    CGFloat floatH;
    CGSize size = CGSizeMake(kScreenWidth-4*mergin_left, MAXFLOAT);
    UIFont *fnt = [UIFont systemFontOfSize:15];
    NSDictionary *tdic = [NSDictionary dictionaryWithObjectsAndKeys:fnt, NSFontAttributeName,nil];
    if (tableView==_tableview1) {
        model = _dataSource[indexPath.row];
    }
    
    if (tableView==_tableview2) {
        model = _dataSource1[indexPath.row];
    }
    
    size =[model.message boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:tdic context:nil].size;
    if (model.type) {
        floatH = size.height<20?20+50:size.height+50;
    } else {
        floatH = 130;
    }
    
    return floatH;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString*key1=@"cell1";
    static NSString*key2=@"cell2";
    XEMessageTableViewCell*cell;
    if (tableView==_tableview1) {
        cell=[tableView dequeueReusableCellWithIdentifier:key1];
        if (cell==nil) {
            cell=[[XEMessageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:key1];
        }
        cell.messageM = _dataSource[indexPath.row];
    }
    
    if (tableView==_tableview2) {
        
        cell=[tableView dequeueReusableCellWithIdentifier:key2];
        if (cell==nil) {
            cell=[[XEMessageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:key2];
        }
        cell.messageM = _dataSource1[indexPath.row];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageDetailViewController *detail = [[MessageDetailViewController alloc] init];
    [self.navigationController pushViewController:detail animated:YES];
}


#pragma mark--实时监听滚动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView==_Scrview2) {
        _Scrview1.contentOffset=CGPointMake(_Scrview2.contentOffset.x/2, 0);
        _Scrview1.frame=CGRectMake(_Scrview2.contentOffset.x/2, CGRectGetMaxY(temRect), kScreenWidth/2, 2);
    }
}

#pragma mark--停止滚动
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if (scrollView==_Scrview2) {
        int i=_Scrview2.contentOffset.x/kScreenWidth;
        UIButton*btn=btnArr[i];
        [tembtn setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
        [btn setTitleColor:ThemeColor forState:UIControlStateNormal];
        tembtn=btn;
    }
}

#pragma mark--文字点击事件
-(void)btn_clicked:(UIButton*)btn {
    
    [tembtn setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
    [btn setTitleColor:ThemeColor forState:UIControlStateNormal];
    
    tembtn=btn;
    if (btn.tag==0) {//1
        [_Scrview2 setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    if (btn.tag==1) {//2
        [_Scrview2 setContentOffset:CGPointMake(kScreenWidth, 0) animated:YES];
    }
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

//
//  BusinessViewController.m
//  XIONGEN
//
//  Created by Ios on 2018/1/16.
//  Copyright © 2018年 Ios. All rights reserved.
//

#import "BusinessViewController.h"
#import "XEHeadTitleView.h"
#import "TYAttributedLabel.h"
#import "RegexKitLite.h"
#import "MessageTableViewCell.h"

@interface BusinessViewController () <UITableViewDelegate,UITableViewDataSource,TYAttributedLabelDelegate>

@property (nonatomic,strong) XEHeadTitleView *headTitleView;
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) NSMutableArray *textContainers;

@end

@implementation BusinessViewController

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
    self.view.backgroundColor = UIColorFromRGB(0xf6f6f6);
    
    self.textContainers = [[NSMutableArray alloc] init];
    [self setNavigtion];
    [self setui];
    [self addTableViewItems];
}

- (void)addTableViewItems {
    
    for (NSInteger i = 0; i < 16; ++i) {
        
        [self.textContainers addObject:[self creatTextContainer]];
    }
    [self.table reloadData];
}

- (TYTextContainer *)creatTextContainer {
    
    NSString *text = @"其实所有漂泊的人，不过是为了有一天能够不再漂泊，能用自己的力量撑起身后的家人和自己爱的人。";
    // 属性文本生成器
    TYTextContainer *textContainer = [[TYTextContainer alloc]init];
    textContainer.text = text;
    
    UIImageView *imageView = [[UIImageView alloc]init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:@"http://imgbdb2.bendibao.com/beijing/201310/21/2013102114858726.jpg"] placeholderImage:[UIImage imageNamed:@"CYLoLi"]];
    imageView.frame = CGRectMake(0, 0, kScreenWidth-3*mergin_left, 120);
    [textContainer addView:imageView range:NSMakeRange(0, 0)];
    
    textContainer.linesSpacing = 2;
    textContainer = [textContainer createTextContainerWithTextWidth:kScreenWidth-3*mergin_left];
    return textContainer;
}

//导航
-(void)setNavigtion {
    if (!_headTitleView) {
        _headTitleView = [[XEHeadTitleView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, SafeAreaTopHeight)];
        _headTitleView.lb_title.text = @"消息";
        _headTitleView.btn_right.hidden = YES;
        [self.view addSubview:_headTitleView];
    }
}

-(void)setui {
    if (!_table) {
        _table = [[UITableView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight, kScreenWidth, kScreenHeight-SafeAreaTopHeight-TabbarHeight)];
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        _table.delegate = self;
        _table.dataSource = self;
        _table.showsVerticalScrollIndicator = NO;
        [self.view addSubview:_table];
    }
}

#pragma mark -tablevidw delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.textContainers.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    TYTextContainer *textContaner = _textContainers[indexPath.row];
    return textContaner.textHeight+50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"messageCell"];
    if (cell == nil) {
        cell = [[MessageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"messageCell"];
    }
    cell.backgroundColor = UIColorFromRGB(0xf2f2f2);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.label.delegate = self;
    cell.label.textContainer = self.textContainers[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击了cell index:%ld",indexPath.row);
}


@end

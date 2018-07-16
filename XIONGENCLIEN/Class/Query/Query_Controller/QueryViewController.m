//
//  QueryViewController.m
//  XIONGEN
//
//  Created by Ios on 2018/1/16.
//  Copyright © 2018年 Ios. All rights reserved.
//

#import "QueryViewController.h"
#import "XEHeadTitleView.h"
#import "XEQueryTabelCell.h"
#import "XECategoryRightView.h"
#import "BrandFilterView.h"
#import "SLSlideMenu.h"
#import "GoodsModel.h"
#import "XECategoryGroupModel.h"
#import "XECategoryModel.h"


@interface QueryViewController () <UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,SLSlideMenuProtocol>

@property (nonatomic,strong) XEHeadTitleView *headTitleView;
@property (nonatomic,strong) XECategoryRightView *rightView;
@property (nonatomic,strong) LeftImageTextField *searchTF;
@property (nonatomic,strong) UITableView *TableView;
@property (nonatomic,strong) NSMutableArray *dataSource;

@property (nonatomic,strong) NSMutableDictionary *dict;
@property (nonatomic,strong) NSMutableArray *filterArr;

@end

@implementation QueryViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.hidden = YES;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [SLSlideMenu dismiss];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = WhiteColor;
    
    [self initData];
    [self setNavigtion];
    [self setUIView];
    [self selectProductByFilterWithDict:nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中..."];
    [self productFilterQuery];
    
    CGRect rect = CGRectMake(0, 0, kScreenWidth, kScreenHeight-SafeAreaBottomHeight);
    [SLSlideMenu prepareSlideMenuWithFrame:rect delegate:self direction:SLSlideMenuSwipeDirectionRight slideOffset:300 allowSlideMenuSwipeShow:YES allowSwipeCloseMenu:YES aboveNav:YES identifier:@"swipeRight1" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadDataWithInfo:) name:@"brandFilter" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:@"SelectGood" object:nil];
}

#pragma mark -数据处理
-(void)initData {
    _dataSource = [[NSMutableArray alloc] init];
    _dict = [[NSMutableDictionary alloc] init];
}

-(void)reloadDataWithInfo:(NSNotification *)notification {
    NSLog(@"notification:\n%@",notification.userInfo);
    [_dict setDictionary:notification.userInfo];
    [self selectProductByFilterWithDict:_dict];
}

-(void)reloadData {
    [_dataSource removeAllObjects];
    [self selectProductByFilterWithDict:_dict];
}

-(void)selectProductByFilterWithDict:(NSMutableDictionary *)dict {
    //转json格式
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:_dict options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
    if (!jsonData) {
        NSLog(@"%@",error);
    }else{
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    WS(weakSelf)
    [HttpRoadData postDataInView:self.view withCone:[NSString stringWithFormat:@"%@%@",BaseURL,@"back/basis/api/selectProductByFilter.do"] jsonString:jsonString completionBlock:^(NSURLResponse *response, NSError *error, id responseObject) {
        
        if (!error) {
            if ([[NSString stringWithFormat:@"%@",responseObject[@"success"]] isEqualToString:@"1"] && [[NSString stringWithFormat:@"%@",responseObject[@"errcode"]] isEqualToString:@"0"]) {
                
                [weakSelf analysisDataWithArray:responseObject[@"data"]];
                
            } else {
                
                [SVProgressHUD showErrorWithStatus:responseObject[@"message"]];
            }
        } else {
            NSLog(@"Error: %@, %@, %@", error, response, responseObject);
        }
    }];
}

-(void)analysisDataWithArray:(NSArray *)data {
    
    [_dataSource removeAllObjects];
    [_dataSource addObjectsFromArray:[GoodsModel mj_objectArrayWithKeyValuesArray:data]];
    [_TableView reloadData];
}

//导航
-(void)setNavigtion {
    if (!_headTitleView) {
        _headTitleView = [[XEHeadTitleView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, SafeAreaTopHeight)];
        _headTitleView.lb_title.text = @"查询";
        [_headTitleView.btn_right setTitle:@"筛选" forState:UIControlStateNormal];
        [_headTitleView.btn_right addTarget:self action:@selector(brandFiltervc) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_headTitleView];
    }
}

//列表
-(void)setUIView {
    if (!_TableView) {
        _TableView = [[UITableView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight+45, kScreenWidth, kScreenHeight-SafeAreaTopHeight-TabbarHeight-45)];
        _TableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _TableView.delegate = self;
        _TableView.dataSource = self;
        _TableView.showsVerticalScrollIndicator = NO;
        [self.view addSubview:_TableView];
        
        [self setTableViewHeadView];
    }
}

//搜索框
-(void)setTableViewHeadView {
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight, kScreenWidth, 45)];
    headView.backgroundColor = UIColorFromRGB(0xeeeeee);
    
    _searchTF = [[LeftImageTextField alloc] initWithFrame:CGRectMake(mergin_left, 5, kScreenWidth-2*mergin_left, 35) Placehold:@"请输入关键字进行搜索" andLeftImageName:@"search@2x"];
    _searchTF.backgroundColor = WhiteColor;
    _searchTF.textColor = UIColorFromRGB(0x333333);
    _searchTF.font = LSYUIFont(15);
    _searchTF.searchIcon.frame = CGRectMake(0, 0, 25, 25                                                                                                                                                                                             );
    [headView addSubview:_searchTF];
    
    [self.view addSubview:headView];
}

#pragma mark -tableView delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    GoodsModel *model;
    if (self.dataSource.count) {
        model = _dataSource[indexPath.row];
    }
    NSString *text;
    if (model.modelname.length) {
        text = [NSString stringWithFormat:@"车型：%@",model.modelname];
    } else if (model.engine.length) {
        text = [NSString stringWithFormat:@"车型：%@",model.engine];
    } else {
        text = [NSString stringWithFormat:@"车型：%@",model.gearbox];
    }
    CGSize size = [self getSizeWithFont:15 andText:text andFload:20];
    return size.height<20?140:size.height+120;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XEQueryTabelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XEQueryTabelCell"];
    if (cell==nil) {
        cell = [[XEQueryTabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"XEQueryTabelCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (self.dataSource.count) {
         cell.good = _dataSource[indexPath.row];
    }
   
    return cell;
}

#pragma mark -- 根据文字获取高度（高度自适应）
-(CGSize)getSizeWithFont:(CGFloat)font  andText:(NSString *)tex andFload:(CGFloat)w{
    
    CGSize size = CGSizeMake(kScreenWidth - w, MAXFLOAT);
    UIFont *fnt = [UIFont systemFontOfSize:font];
    NSDictionary *tdic = [NSDictionary dictionaryWithObjectsAndKeys:fnt, NSFontAttributeName,nil];
    size =[tex boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:tdic context:nil].size;
    return size;
}

#pragma mark -品牌筛选
-(void)brandFiltervc {
    
    [SLSlideMenu slideMenuWithFrame:self.view.frame delegate:self direction:SLSlideMenuDirectionRight slideOffset:300 allowSwipeCloseMenu:YES aboveNav:YES identifier:@"right1" object:nil];
}

#pragma mark -SLSlideMenu delegate
- (void)slideMenu:(SLSlideMenu *)slideMenu prepareSubviewsForMenuView:(UIView *)menuView {
    
    NSLog(@"identifier:%@",slideMenu.identifier);
    //    // 可以通过 slideMenu.object 获取传进来的参数
    //    NSLog(@"object: %@",slideMenu.object);
    
    // ** 如果一个方向只有一个弹窗可根据direction区分
    
    if (slideMenu.direction == SLSlideMenuDirectionRight) {
        
        BrandFilterView *brandV = [[BrandFilterView alloc] initWithFrame:CGRectMake(0, 0, 300, kScreenHeight) andDataArray:_filterArr];
        [menuView addSubview:brandV];
    }
    
    // ** 如果一个方向有多个弹窗，可设置identifier来区分
    if ([slideMenu.identifier isEqualToString:@"right1"]) {
        menuView.backgroundColor = [UIColor greenColor];
    }
    
}

-(void)slideViewDismiss {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"brandFilterView" object:self];
}


#pragma mark - 商品筛选接口
-(void)productFilterQuery {
    
    [HttpRoadData GetAFNInfoInViewNo:self.view withVersionCode:[NSString stringWithFormat:@"%@%@",BaseURL,@"back/basis/api/productFilterQuery.do"] NSMutableDictionary:nil successBlock:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *parm = responseObject;
        if ([[NSString stringWithFormat:@"%@",parm[@"success"]] isEqualToString:@"1"] && [[NSString stringWithFormat:@"%@",parm[@"errcode"]] isEqualToString:@"0"]) {
            
            [self analysisDataWithDictionary:parm[@"data"]];
            
        } else {
            [SVProgressHUD showErrorWithStatus:parm[@"message"]];
        }
        
    } failureBlock:^(NSURLSessionDataTask *task, NSError *error) {
        
        
    }];
}

-(void)analysisDataWithDictionary:(NSDictionary *)dict {
    
    _filterArr = [[NSMutableArray alloc] init];
    
    NSArray *yearArr = [dict objectForKey:@"years"];
    NSArray *carArr = [dict objectForKey:@"car"];
    NSArray *brandArr = [dict objectForKey:@"brandname"];
    NSArray *displaceArr = [dict objectForKey:@"displacement"];
    NSArray *engineArr = [dict objectForKey:@"engine"];
    NSArray *gearboxArr = [dict objectForKey:@"gearbox"];
    NSArray *modelArr = [dict objectForKey:@"modelname"];
    
    NSArray *arr = @[@"年份",@"车型",@"品牌",@"排量",@"发动机型号",@"波箱型号",@"底盘型号"];
    for (int i=0; i<7; i++) {
        XECategoryGroupModel *group = [[XECategoryGroupModel alloc] init];
        group.title = arr[i];
        switch (i) {
            case 0:
            {
                if (yearArr.count) {
                    [group.category addObjectsFromArray:[self analysisFilterQueryDataWithArray:yearArr]];
                    [_filterArr addObject:group];
                }
            }
                break;
            case 1:
            {
                if (carArr.count) {
                    [group.category addObjectsFromArray:[self analysisFilterQueryDataWithArray:carArr]];
                    [_filterArr addObject:group];
                }
            }
                break;
            case 2:
            {
                if (brandArr.count) {
                    [group.category addObjectsFromArray:[self analysisFilterQueryDataWithArray:brandArr]];
                    [_filterArr addObject:group];
                }
            }
                break;
            case 3:
            {
                if (displaceArr.count) {
                    [group.category addObjectsFromArray:[self analysisFilterQueryDataWithArray:displaceArr]];
                    [_filterArr addObject:group];
                }
            }
                break;
            case 4:
            {
                if (engineArr.count) {
                    [group.category addObjectsFromArray:[self analysisFilterQueryDataWithArray:engineArr]];
                    [_filterArr addObject:group];
                }
            }
                break;
            case 5:
            {
                if (gearboxArr.count) {
                    [group.category addObjectsFromArray:[self analysisFilterQueryDataWithArray:gearboxArr]];
                    [_filterArr addObject:group];
                }
            }
                break;
            case 6:
            {
                if (modelArr.count) {
                    [group.category addObjectsFromArray:[self analysisFilterQueryDataWithArray:modelArr]];
                    [_filterArr addObject:group];
                }
            }
                break;
                
            default:
                break;
        }
    }
}

-(NSArray *)analysisFilterQueryDataWithArray:(NSArray *)arr {
    NSMutableArray *muta = [[NSMutableArray alloc] init];
    for (int i=0; i<arr.count; i++) {
        XECategoryModel *model = [[XECategoryModel alloc] init];
        model.category = arr[i];
        [muta addObject:model];
    }
    return muta;
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"brandFilter" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"SelectGood" object:nil];
}

@end

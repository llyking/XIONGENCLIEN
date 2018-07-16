//
//  AddOrderViewController.m
//  XIONGEN
//
//  Created by Ios on 2018/1/25.
//  Copyright © 2018年 Ios. All rights reserved.
//

#import "AddOrderViewController.h"
#import "GoodsTableViewCell.h"
#import "GoodsModel.h"

@interface AddOrderViewController () <UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic,strong) LeftImageTextField *searchTF;
@property (nonatomic,strong) UITableView *TableView;
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,strong) NSMutableArray *selectGoods;

@property (nonatomic,strong) UILabel *lb_price;
@property (nonatomic,strong) UILabel *lb_number;

@property (nonatomic,strong) SQLiteManager *manager;

@end

@implementation AddOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.Namelab.text = @"客户下单";
    _dataSource = [[NSMutableArray alloc] init];
    _selectGoods = [[NSMutableArray alloc] init];
    
    [[SQLiteManager shareManager]open];
    _manager = [SQLiteManager shareManager];
    
    [self setUIView];
    [self productQueryByKeyword];
}

#pragma mark -获取接口数据
-(void)productQueryByKeyword {
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:_searchTF.text,@"keyword",USERID,@"userId", nil];;
    [HttpRoadData GetAFNInfoInViewNo:self.view withVersionCode:[NSString stringWithFormat:@"%@%@",BaseURL,@"back/basis/api/productQueryByKeyword.do"] NSMutableDictionary:dict successBlock:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *parm = responseObject;
        if ([[NSString stringWithFormat:@"%@",parm[@"success"]] isEqualToString:@"1"] && [[NSString stringWithFormat:@"%@",parm[@"errcode"]] isEqualToString:@"0"]) {
            
            [self analysisWithData:parm[@"data"]];
            
        } else {
            [SVProgressHUD showErrorWithStatus:parm[@"message"]];
        }
    } failureBlock:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
     
}

-(void)analysisWithData:(NSArray *)data {
    
    if (data.count>0&&_dataSource.count>0) {
        [_dataSource removeAllObjects];
    }
    [_dataSource addObjectsFromArray:[GoodsModel mj_objectArrayWithKeyValuesArray:data]];
    
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    [dataArray addObjectsFromArray:[[SQLiteManager shareManager] selectGood]];
    
    if (dataArray.count) {
        for (int i=0; i<dataArray.count; i++) {
            GoodsModel *model = dataArray[i];
            for (int j=0; j<_dataSource.count; j++) {
                GoodsModel *good = _dataSource[j];
                if (good.fid==model.fid) {
                    good.count = model.count;
                }
            }
        }
    }
    [self priceCalculationpramk];
    [_TableView reloadData];
}

//列表
-(void)setUIView {
    if (!_TableView) {
        _TableView = [[UITableView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight+45, kScreenWidth, kScreenHeight-SafeAreaTopHeight-SafeAreaBottomHeight-45-55)];
        _TableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _TableView.delegate = self;
        _TableView.dataSource = self;
        _TableView.showsVerticalScrollIndicator = NO;
        [self.view addSubview:_TableView];
    }
    [self setTableViewHeadView];
    [self setFooterView];
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
    _searchTF.delegate = self;
    _searchTF.returnKeyType = UIReturnKeySearch;
    [headView addSubview:_searchTF];
    
    [self.view addSubview:headView];
}

#pragma mark - textField delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self productQueryByKeyword];
    return YES;
}

-(void)setFooterView {
    UIView *footerV = [[UIView alloc] init];
    footerV.frame = CGRectMake(0, kScreenHeight-SafeAreaBottomHeight-55, kScreenWidth, 55);
    footerV.backgroundColor = WhiteColor;
    [self.view addSubview:footerV];
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 1)];
    line.backgroundColor = LineColor;
    [footerV addSubview:line];
    
    if (!_lb_price) {
        _lb_price = [[UILabel alloc] init];
        _lb_price.frame = CGRectMake(kScreenWidth-135-150, 15, 150, 25);
        _lb_price.textColor = UIColorFromRGB(0x333333);
        _lb_price.textAlignment = NSTextAlignmentRight;
        _lb_price.font = LSYUIFont(15);
        [footerV addSubview:_lb_price];
    }
    
    UIButton *finish = [UIButton buttonWithType:UIButtonTypeCustom];
    finish.frame = CGRectMake(kScreenWidth-120, 0, 120, 55);
    finish.backgroundColor = ThemeColor;
    [finish setTitle:@"完成添加" forState:UIControlStateNormal];
    [finish setTitleColor:WhiteColor forState:UIControlStateNormal];
    finish.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    finish.titleLabel.font = LSYUIFont(17);
    [finish addTarget:self action:@selector(finishAction) forControlEvents:UIControlEventTouchUpInside];
    [footerV addSubview:finish];
    
    UIImageView *img_cicle = [[UIImageView alloc] init];
    img_cicle.frame = CGRectMake(15, CGRectGetMinY(footerV.frame)-20, 60, 60);
    img_cicle.layer.cornerRadius = 30;
    img_cicle.layer.masksToBounds = YES;
    img_cicle.backgroundColor = ThemeColor;
    [self.view addSubview:img_cicle];
    
    UIImageView *img_car = [[UIImageView alloc] init];
    img_car.frame = CGRectMake(15, 15, 30, 30);
    img_car.image = [UIImage imageWithContentsOfFile:ImagePath(@"order_car@2x")];
    [img_cicle addSubview:img_car];
    
    if (!_lb_number) {
        _lb_number = [[UILabel alloc] init];
        _lb_number.frame = CGRectMake(CGRectGetMaxX(img_cicle.frame)-15, CGRectGetMinY(footerV.frame)-15, 20, 20);
        _lb_number.layer.cornerRadius = 10;
        _lb_number.layer.masksToBounds = YES;
        _lb_number.backgroundColor = [UIColor redColor];
        _lb_number.textColor = WhiteColor;
        _lb_number.textAlignment = NSTextAlignmentCenter;
        _lb_number.font = LSYUIFont(10);
        [self.view addSubview:_lb_number];
    }
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
    CGSize size = [self getSizeWithFont:13 andText:text andFload:20];
    return size.height<20?160:size.height+140;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GoodsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"goods"];
    if (cell==nil) {
        cell = [[GoodsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"goods"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    GoodsModel *goodsModel = _dataSource[indexPath.row];
    cell.goods = goodsModel;
    
    //把事件的处理分离出去
    [self shoppingCartCellClickAction:cell goodsModel:goodsModel indexPath:indexPath];
    return cell;
}


#pragma mark - 编辑代理(数量) -
-(void)shoppingCartCellClickAction:(GoodsTableViewCell *)cell goodsModel:(GoodsModel *)goodsModel indexPath:(NSIndexPath *)indexPath {
    
    //加
    cell.AddBlock = ^(UILabel *countLabel) {
        _lb_number.text = [NSString stringWithFormat:@"%d",[_lb_number.text intValue]+1];
        goodsModel.count = [countLabel.text intValue];
        [_dataSource replaceObjectAtIndex:indexPath.row withObject:goodsModel];
        [self priceCalculationpramk];
    };
    
    //减
    cell.CutBlock = ^(UILabel *countLabel) {
        _lb_number.text = [NSString stringWithFormat:@"%d",[_lb_number.text intValue]-1];
        goodsModel.count = [countLabel.text intValue];
        [_dataSource replaceObjectAtIndex:indexPath.row withObject:goodsModel];
        [self priceCalculationpramk];
    };
    
    [[SQLiteManager shareManager] updateGoodCount:goodsModel];
}

#pragma mark - 价格计算 -
-(void)priceCalculationpramk{
   
    float money=0.0;
    int count=0;
    for (int i=0; i<_dataSource.count; i++) {
        GoodsModel *good = _dataSource[i];
        if (good.count>0) {
            money = money+good.count*good.price;
            count +=good.count;
        }
    }
    
    _lb_price.text = [NSString stringWithFormat:@"合计:￥%.2f",money];
    _lb_number.text = [NSString stringWithFormat:@"%d",count];
    NSString *moneyStr = [NSString stringWithFormat:@"%.2f",money];
    // 创建Attributed
    NSMutableAttributedString *aString = [[NSMutableAttributedString alloc] initWithString:_lb_price.text];
    [aString addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x333333) range:NSMakeRange(0,3)];
    [aString addAttribute:NSForegroundColorAttributeName value:ThemeColor range:NSMakeRange(3,moneyStr.length+1)];
    // 为label添加Attributed
    [_lb_price setAttributedText:aString];
}

#pragma mark - 完成添加
-(void)finishAction {
    
    for (int i=0; i<_dataSource.count; i++) {
        GoodsModel *good = _dataSource[i];
        if (good.count>0) {
            [_selectGoods addObject:good];
        }
    }
    
    for (int i=0; i<_selectGoods.count; i++) {
        GoodsModel *model = _selectGoods[i];
        BOOL b = [[SQLiteManager shareManager]selectGoodWithGoodFid:model.fid];
        if (!b) {
            [[SQLiteManager shareManager]insertGood:model];
        }
    }
    NSLog(@"%@",_selectGoods);
    if (self.reloadBlock) {
        self.reloadBlock();
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -- 根据文字获取高度（高度自适应）
-(CGSize)getSizeWithFont:(CGFloat)font  andText:(NSString *)tex andFload:(CGFloat)w{
    
    CGSize size = CGSizeMake(kScreenWidth - w, MAXFLOAT);
    UIFont *fnt = [UIFont systemFontOfSize:font];
    NSDictionary *tdic = [NSDictionary dictionaryWithObjectsAndKeys:fnt, NSFontAttributeName,nil];
    size =[tex boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:tdic context:nil].size;
    return size;
}

-(void)backButtonBar {
    if (self.reloadBlock) {
        self.reloadBlock();
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end

//
//  PlaceOrderViewController.m
//  XIONGEN
//
//  Created by Ios on 2018/1/23.
//  Copyright © 2018年 Ios. All rights reserved.
//

#import "PlaceOrderViewController.h"
#import "AddOrderViewController.h"
#import "ReciveAdressViewController.h"
#import "PlaceOrderTableViewCell.h"
#import "XEInputBoxView.h"
#import "XEComboBox.h"
#import "ReciveAdressModel.h"

@interface PlaceOrderViewController () <UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>
{
    NSString *timeString;
    NSMutableArray *_shippingArray;
    BOOL shippingStatus;
}

@property (nonatomic,strong) UIView *headView;
@property (nonatomic,strong) BroughtButton *adress;

@property (nonatomic,strong) UIView *recivedView;
@property (nonatomic,strong) UILabel *recivedMan;
@property (nonatomic,strong) UILabel *recivedPhone;
@property (nonatomic,strong) UILabel *recivedAdress;
@property (nonatomic,strong) UILabel *shippingType;
@property (nonatomic,strong) UILabel *logistForm;
@property (nonatomic,strong) UILabel *logistCompany;

@property (nonatomic,strong) UITextView *remarktv;
@property (nonatomic,strong) UILabel *remarklb;

@property (nonatomic,strong) UITableView *tableV;
@property (nonatomic,strong) NSMutableArray *dataSource;

//
@property (nonatomic,strong) UILabel *lb_price;
@property (nonatomic,strong) UILabel *lb_kinds;
@property (nonatomic,strong) UILabel *lb_number;

@property (nonatomic,assign) int addressid;


@end

@implementation PlaceOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.Namelab.text = @"客户下单";
    self.view.backgroundColor = UIColorFromRGB(0xf6f6f6);
    _dataSource = [[NSMutableArray alloc] init];
    [self createUIView];
    [self getGoodData];
}

#pragma mark -获取数据
-(void)getGoodData {
    [_dataSource addObjectsFromArray:[[SQLiteManager shareManager] selectGood]];
    [self refresh];
    [_tableV reloadData];
}

-(void)refresh {
    
    float money=0.0;
    int count=0;
    for (int i=0; i<_dataSource.count; i++) {
        GoodsModel *model = [_dataSource objectAtIndex:i];
        money += model.count*model.price;
        count += model.count;
    }
    
    _lb_price.text = [NSString stringWithFormat:@"¥ %.2f",money];
    _lb_kinds.text = [NSString stringWithFormat:@"共 %ld",_dataSource.count];
    _lb_number.text = [NSString stringWithFormat:@"数量 %d",count];
}

//列表
-(void)createUIView {
    if (!_tableV) {
        _tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight, kScreenWidth, kScreenHeight-SafeAreaTopHeight-SafeAreaBottomHeight-55) style:UITableViewStylePlain];
        _tableV.delegate = self;
        _tableV.dataSource = self;
        _tableV.tableFooterView = [[UIView alloc] init];
        [self.view addSubview:_tableV];
    }
    [self createTableHeadView];
    [self setFooterView];
}

//底部提交
-(void)setFooterView {
    UIView *footerV = [[UIView alloc] init];
    footerV.frame = CGRectMake(0, kScreenHeight-SafeAreaBottomHeight-55, kScreenWidth, 55);
    footerV.backgroundColor = WhiteColor;
    [self.view addSubview:footerV];
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 1)];
    line.backgroundColor = LineColor;
    [footerV addSubview:line];
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(mergin_left, 10, 100, 35);
    addBtn.backgroundColor = WhiteColor;
    [addBtn setTitle:@"合计:" forState:UIControlStateNormal];
    [addBtn setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
    addBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    addBtn.titleLabel.font = LSYUIFont(15);
    [addBtn addTarget:self action:@selector(addOrderAction) forControlEvents:UIControlEventTouchUpInside];
    [addBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, addBtn.imageView.frame.size.width-20, 0, -addBtn.imageView.frame.size.width)];
    [addBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -addBtn.titleLabel.bounds.size.width+28, 0, addBtn.titleLabel.bounds.size.width)];
    [addBtn setImage:[UIImage imageWithContentsOfFile:ImagePath(@"order_add@2x")] forState:UIControlStateNormal];
    [footerV addSubview:addBtn];
    
    if (!_lb_price) {
        _lb_price = [[UILabel alloc] init];
        _lb_price.frame = CGRectMake(CGRectGetMaxX(addBtn.frame), 5, 100, 20);
        _lb_price.textColor = UIColorFromRGB(0x666666);
        _lb_price.textAlignment = NSTextAlignmentLeft;
        _lb_price.font = LSYUIFont(13);
        [footerV addSubview:_lb_price];
    }
    
    if (!_lb_kinds) {
        _lb_kinds = [[UILabel alloc] init];
        _lb_kinds.frame = CGRectMake(CGRectGetMaxX(addBtn.frame), CGRectGetMaxY(_lb_price.frame)+5, 100, 20);
        _lb_kinds.textColor = UIColorFromRGB(0x666666);
        _lb_kinds.textAlignment = NSTextAlignmentLeft;
        _lb_kinds.font = LSYUIFont(13);
        [footerV addSubview:_lb_kinds];
    }
    
    if (!_lb_number) {
        _lb_number = [[UILabel alloc] init];
        _lb_number.frame = CGRectMake(CGRectGetMaxX(_lb_kinds.frame), CGRectGetMaxY(_lb_price.frame)+5, 100, 20);
        _lb_number.textColor = UIColorFromRGB(0x666666);
        _lb_number.textAlignment = NSTextAlignmentLeft;
        _lb_number.font = LSYUIFont(13);
        [footerV addSubview:_lb_number];
    }
    
    UIButton *post = [UIButton buttonWithType:UIButtonTypeCustom];
    post.frame = CGRectMake(kScreenWidth-120, 0, 120, 55);
    post.backgroundColor = ThemeColor;
    [post setTitle:@"提交" forState:UIControlStateNormal];
    [post setTitleColor:WhiteColor forState:UIControlStateNormal];
    post.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    post.titleLabel.font = LSYUIFont(15);
     [post addTarget:self action:@selector(postOrderAction) forControlEvents:UIControlEventTouchUpInside];
    [footerV addSubview:post];
}

//列表头部视图
-(void)createTableHeadView {
    
    _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
    _headView.backgroundColor = UIColorFromRGB(0xf6f6f6);
    _tableV.tableHeaderView = _headView;
    
    _adress = [[BroughtButton alloc] initWithFrame:CGRectMake(0, 15, kScreenWidth, 45)];
    _adress.left_imgV.hidden = YES;
    _adress.right_lab.hidden = YES;
    _adress.left_lab.frame = CGRectMake(15, 0, 300, 45);
    _adress.left_lab.text = @"请选择收货地址";
    [_adress addTarget:self action:@selector(receivedAdress) forControlEvents:UIControlEventTouchUpInside];
    [_headView addSubview:_adress];
    
    _recivedView = [self setRecievedViewWithFrame:_adress.frame];
    [_headView addSubview:_recivedView];
    
    if (!_remarktv) {
        _remarktv = [[UITextView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_adress.frame)+10, kScreenWidth, 100)];
        _remarktv.textColor = UIColorFromRGB(0x333333);
        _remarktv.textAlignment = NSTextAlignmentLeft;
        _remarktv.font = LSYUIFont(13);
        _remarktv.delegate = self;
        _remarktv.editable = YES;
        _remarktv.layer.borderColor = LineColor.CGColor;
        _remarktv.layer.borderWidth = 1.0f;
        [_headView addSubview:_remarktv];
    }
    
    if (!_remarklb) {
        _remarklb = [[UILabel alloc] init];
        _remarklb.frame = CGRectMake(CGRectGetMinX(_remarktv.frame)+5, CGRectGetMinY(_remarktv.frame)+8, 100, 15);
        _remarklb.text = @"输入备注";
        _remarklb.textColor = UIColorFromRGB(0x999999);
        _remarklb.textAlignment = NSTextAlignmentLeft;
        _remarklb.font = LSYUIFont(13);
        [_headView addSubview:_remarklb];
    }
    _headView.frame = CGRectMake(0, 0, kScreenWidth, CGRectGetMaxY(_remarktv.frame)+10);
}

-(UIView *)setRecievedViewWithFrame:(CGRect)frame {
    _recivedView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(frame), kScreenWidth, 0)];
    _recivedView.backgroundColor = WhiteColor;
    
    _recivedMan = [[UILabel alloc] initWithFrame:CGRectMake(mergin_left, 5, (kScreenWidth-2*mergin_left)/2, 20)];
    _recivedMan.textColor = UIColorFromRGB(0x333333);
    _recivedMan.textAlignment = NSTextAlignmentLeft;
    _recivedMan.font = LSYUIFont(15);
    [_recivedView addSubview:_recivedMan];
    
    _recivedPhone = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_recivedMan.frame), 5, (kScreenWidth-2*mergin_left)/2, 20)];
    _recivedPhone.textColor = UIColorFromRGB(0x333333);
    _recivedPhone.textAlignment = NSTextAlignmentLeft;
    _recivedPhone.font = LSYUIFont(15);
    [_recivedView addSubview:_recivedPhone];
    
    _recivedAdress = [[UILabel alloc] initWithFrame:CGRectMake(mergin_left, CGRectGetMaxY(_recivedMan.frame)+5, kScreenWidth-2*mergin_left, 20)];
    _recivedAdress.textColor = UIColorFromRGB(0x333333);
    _recivedAdress.textAlignment = NSTextAlignmentLeft;
    _recivedAdress.font = LSYUIFont(15);
    [_recivedView addSubview:_recivedAdress];
    
    _shippingType = [[UILabel alloc] initWithFrame:CGRectMake(mergin_left, CGRectGetMaxY(_recivedAdress.frame)+5, (kScreenWidth-2*mergin_left)/2, 20)];
    _shippingType.textColor = UIColorFromRGB(0x333333);
    _shippingType.textAlignment = NSTextAlignmentLeft;
    _shippingType.font = LSYUIFont(15);
    [_recivedView addSubview:_shippingType];
    
    _logistForm = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_shippingType.frame), CGRectGetMaxY(_recivedAdress.frame)+5, (kScreenWidth-2*mergin_left)/2, 20)];
    _logistForm.textColor = UIColorFromRGB(0x333333);
    _logistForm.textAlignment = NSTextAlignmentLeft;
    _logistForm.font = LSYUIFont(15);
    _logistForm.hidden = YES;
    [_recivedView addSubview:_logistForm];
    
    _logistCompany = [[UILabel alloc] initWithFrame:CGRectMake(mergin_left, CGRectGetMaxY(_shippingType.frame)+5, kScreenWidth-2*mergin_left, 20)];
    _logistCompany.textColor = UIColorFromRGB(0x333333);
    _logistCompany.textAlignment = NSTextAlignmentLeft;
    _logistCompany.font = LSYUIFont(15);
    _logistCompany.hidden = YES;
    [_recivedView addSubview:_logistCompany];
    
    return _recivedView;
}

#pragma mark - 选择收货地址
-(void)showRecivedInfoWithModel:(ReciveAdressModel *)model {
    
    _recivedView.frame = CGRectMake(0, CGRectGetMaxY(_adress.frame)+10, kScreenWidth, 80);
    _logistForm.hidden = YES;
    _logistCompany.hidden = YES;
    
    if (model.logisCompany) {
        _recivedView.frame = CGRectMake(0, CGRectGetMaxY(_adress.frame)+10, kScreenWidth, 105);
        _logistForm.hidden = NO;
        _logistCompany.hidden = NO;
    }
    
    UILabel *line = [[UILabel alloc] init];
    line.frame = CGRectMake(0, _recivedView.frame.size.height-1, kScreenWidth, 1);
    line.backgroundColor = LineColor;
    [_recivedView addSubview:line];
    
    
    _remarktv.frame = CGRectMake(0, CGRectGetMaxY(_recivedView.frame)+10, kScreenWidth, 100);
    _remarklb.frame = CGRectMake(CGRectGetMinX(_remarktv.frame)+5, CGRectGetMinY(_remarktv.frame)+8, 100, 15);
    _headView.frame = CGRectMake(0, 0, kScreenWidth, CGRectGetMaxY(_remarktv.frame)+10);
   
    _recivedMan.text = [NSString stringWithFormat:@"收货人：%@",model.contact];
    _recivedPhone.text = [NSString stringWithFormat:@"电话：%@",model.phone];
    _recivedAdress.text = [NSString stringWithFormat:@"地址：%@",model.address];
    _shippingType.text = [NSString stringWithFormat:@"配送方式：%@",model.form];
    _logistForm.text = [NSString stringWithFormat:@"运输方式：%@",model.logisForm];
    _logistCompany.text = [NSString stringWithFormat:@"物流公司：%@",model.logisCompany];
    
    [_tableV reloadData];
}


#pragma mark -tableView delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PlaceOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"placeorder"];
    if (cell==nil) {
        cell = [[PlaceOrderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"placeorder"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = _dataSource[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // 删除数据源的数据,self.cellData是你自己的数据
        [self.dataSource removeObjectAtIndex:indexPath.row];
        [self refresh];
        // 删除列表中数据
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return @"删除";//默认文字为 Delete
}

#pragma mark -textView delegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    NSString *newText = [textView.text stringByReplacingCharactersInRange:range withString:text];
    
    if (newText.length>0) {
        _remarklb.hidden = YES;
    } else {
        _remarklb.hidden = NO;
    }
    return YES;
}

#pragma mark - 收货地址
-(void)receivedAdress {
    ReciveAdressViewController *vc = [[ReciveAdressViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
    WS(weakSelf)
    [vc setAdressBlock:^(ReciveAdressModel *model) {
        [weakSelf showRecivedInfoWithModel:model];
        weakSelf.addressid = model.fid;
    }];
}

#pragma mark -添加订单
-(void)addOrderAction {
    WS(weakSelf)
    AddOrderViewController *addgoods = [[AddOrderViewController alloc] init];
    [addgoods setReloadBlock:^{
        [weakSelf getGoodData];
    }];
    [self.navigationController pushViewController:addgoods animated:YES];
}

#pragma mark -提交订单
-(void)postOrderAction {
    
    if (self.recivedMan.text.length==0||self.recivedPhone.text.length==0||self.recivedAdress.text.length==0||self.shippingType.text.length==0) {
        [SVProgressHUD showErrorWithStatus:@"请选择收货地址"];
        return;
    }
    
    if (!self.dataSource.count) {
        [SVProgressHUD showErrorWithStatus:@"请按➕添加商品"];
        return;
    }
    
    //接口参数处理
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (int i=0; i<_dataSource.count; i++) {
        GoodsModel *model = [_dataSource objectAtIndex:i];
        NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:@(model.fid),@"commodityId",@(model.count),@"count", nil];
        [arr addObject:dict];
    }
    
    
    //接口参数
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:arr,@"data",@(9),@"customerid",@(_addressid),@"addressid",_remarktv.text,@"remarks", nil];
    
    //转json格式
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
    if (!jsonData) {
        NSLog(@"%@",error);
    }else{
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    WS(weakSelf)
    [HttpRoadData postDataInView:self.view withCone:[NSString stringWithFormat:@"%@%@",BaseURL,@"back/customerOrder/saveCustomerOrder.do"] jsonString:jsonString completionBlock:^(NSURLResponse *response, NSError *error, id responseObject) {
        
        if (!error) {
            if ([[NSString stringWithFormat:@"%@",responseObject[@"success"]] isEqualToString:@"1"] && [[NSString stringWithFormat:@"%@",responseObject[@"errcode"]] isEqualToString:@"0"]) {
                
                [weakSelf.dataSource removeAllObjects];
                [weakSelf refreshRecieView];
                [[SQLiteManager shareManager] delelteTable];
                
            } else {
                
                [SVProgressHUD showErrorWithStatus:responseObject[@"message"]];
            }
            
        } else {
            NSLog(@"Error: %@, %@, %@", error, response, responseObject);
            [SVProgressHUD dismiss];
        }
    }];
}

-(void)refreshRecieView {
    _recivedView.frame = CGRectMake(0, CGRectGetMaxY(_adress.frame)+10, kScreenWidth, 0);
    _remarktv.frame = CGRectMake(0, CGRectGetMaxY(_recivedView.frame), kScreenWidth, 100);
    _remarklb.frame = CGRectMake(CGRectGetMinX(_remarktv.frame)+5, CGRectGetMinY(_remarktv.frame)+8, 100, 15);
    _headView.frame = CGRectMake(0, 0, kScreenWidth, CGRectGetMaxY(_remarktv.frame)+10);
    
    _lb_price.text = @"";
    _lb_kinds.text = @"";
    _lb_number.text = @"";
    _remarktv.text = @"";
    _remarklb.hidden = NO;
    
    [_tableV reloadData];
}

-(void)backButtonBar {
    [[SQLiteManager shareManager] close];
    [self.navigationController popViewControllerAnimated:YES];
}



@end

//
//  BrandFilterView.m
//  XIONGENCLIEN
//
//  Created by Ios on 2018/3/29.
//  Copyright © 2018年 Ios. All rights reserved.
//

#import "BrandFilterView.h"
#import "XEBrandFilterCell.h"
#import "XECategoryGroupModel.h"
#import "XECategoryModel.h"

@interface BrandFilterView () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UITextField *minTF;
@property (nonatomic,strong) UITextField *maxTF;

@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,strong) NSMutableArray *selectArray;


@end


@implementation BrandFilterView

-(instancetype)initWithFrame:(CGRect)frame andDataArray:(NSArray *)array {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.dataSource = [[NSMutableArray alloc] init];
        [self.dataSource addObjectsFromArray:array];
        [self createNavigationAndTopView];
        [self createCollectionVeiw];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectData) name:@"brandFilterView" object:nil];
    }
    return self;
}

-(void)createNavigationAndTopView {
    
    UIView *naV = [[UIView alloc] init];
    naV.frame = CGRectMake(0, 0, self.frame.size.width, SafeAreaTopHeight);
    naV.backgroundColor = ThemeColor;
    [self addSubview:naV];
    
    UILabel *title = [[UILabel alloc] init];
    title.frame = CGRectMake(0, StatubarHeight, self.frame.size.width, NavigtionHeight);
    title.text = @"筛选";
    title.textColor = WhiteColor;
    title.textAlignment = NSTextAlignmentCenter;
    title.font = LSYUIFont(17);
    [naV addSubview:title];
    
     UIButton *_btn_right = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn_right.frame = CGRectMake(naV.frame.size.width-60, StatubarHeight, 50, NavigtionHeight);
    [_btn_right setTitle:@"重置" forState:UIControlStateNormal];
    [_btn_right setTitleColor:WhiteColor forState:UIControlStateNormal];
    [_btn_right addTarget:self action:@selector(topBtnAction) forControlEvents:UIControlEventTouchUpInside];
    _btn_right.titleLabel.font = LSYUIFont(13);
    _btn_right.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [_btn_right setTitleColor:WhiteColor forState:UIControlStateNormal];
    [naV addSubview:_btn_right];
    
    
    UIView *topV = [[UIView alloc] init];
    topV.frame =CGRectMake(0, SafeAreaTopHeight, self.frame.size.width, 75);
    topV.backgroundColor = WhiteColor;
    [self addSubview:topV];
    
    UILabel *countLb = [[UILabel alloc] init];
    countLb.frame = CGRectMake(10, 5, 150, 20);
    countLb.text = @"可售数量";
    countLb.textColor = UIColorFromRGB(0x333333);
    countLb.textAlignment = NSTextAlignmentLeft;
    countLb.font = LSYUIFont(15);
    [topV addSubview:countLb];
    
    _minTF = [[UITextField alloc] init];
    _minTF.frame = CGRectMake(CGRectGetMinX(countLb.frame)+20, CGRectGetMaxY(countLb.frame)+10, 60, 30);
    _minTF.textAlignment = NSTextAlignmentCenter;
    _minTF.textColor = UIColorFromRGB(0x333333);
    _minTF.backgroundColor = UIColorFromRGB(0xf6f6f6);
    _minTF.font = LSYUIFont(15);
    [topV addSubview:_minTF];
    
    UILabel *line = [[UILabel alloc] init];
    line.frame = CGRectMake(CGRectGetMaxX(_minTF.frame), CGRectGetMaxY(countLb.frame)+10, 50, 30);
    line.text = @"--";
    line.textColor = UIColorFromRGB(0x333333);
    line.textAlignment = NSTextAlignmentCenter;
    line.font = LSYUIFont(15);
    [topV addSubview:line];
    
    _maxTF = [[UITextField alloc] init];
    _maxTF.frame = CGRectMake(CGRectGetMaxX(line.frame), CGRectGetMaxY(countLb.frame)+10, 60, 30);
    _maxTF.textAlignment = NSTextAlignmentCenter;
    _maxTF.textColor = UIColorFromRGB(0x333333);
    _maxTF.backgroundColor = UIColorFromRGB(0xf6f6f6);
    _maxTF.font = LSYUIFont(15);
    [topV addSubview:_maxTF];
}

#pragma mark --createCollectionVeiw
-(void)createCollectionVeiw {
    
    //此处必须要有创见一个UICollectionViewFlowLayout的对象
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    //同一行相邻两个cell的最小间距
    layout.minimumInteritemSpacing = 5;
    //最小两行之间的间距
    layout.minimumLineSpacing = 5;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight+75, self.frame.size.width, kScreenHeight-SafeAreaTopHeight-75-TabbarHeight) collectionViewLayout:layout];
    _collectionView.backgroundColor = WhiteColor;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    layout.scrollDirection=UICollectionViewScrollDirectionVertical;
    [self addSubview:_collectionView];
    
    //这种是原生cell的注册
    [_collectionView registerClass:[XEBrandFilterCell class] forCellWithReuseIdentifier:@"XEBrandFilterCell"];
    
    //这是头部与脚部的注册
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView"];
}

#pragma mark --collectionView delegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _dataSource.count;
}
//每一组有多少个cell
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    XECategoryGroupModel *group = [_dataSource objectAtIndex: section];
    return group.category.count;
}

//每一个cell是什么
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    XEBrandFilterCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"XEBrandFilterCell" forIndexPath:indexPath];
    cell.backgroundColor = UIColorFromRGB(0xf6f6f6);
    XECategoryGroupModel *group = [_dataSource objectAtIndex: indexPath.section];
    cell.model = [group.category objectAtIndex: indexPath.row];
    WS(weakSelf)
    [cell setChooseCategoryItemCallBack:^{
        [weakSelf chooseCategoryItemWithIndexPath:indexPath];
    }];
    
    return cell;
}

//头部和脚部的加载
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    XECategoryGroupModel *group = [_dataSource objectAtIndex: indexPath.section];
    UICollectionReusableView *reusableView =nil;
    if (kind == UICollectionElementKindSectionHeader) {
        reusableView=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"headerView" forIndexPath:indexPath];
        [reusableView addSubview:[self setTableViewHeadViewWithTitle:group.title]];
    }
    return reusableView;
}

//每一个分组的上左下右间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

//头部试图的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(self.frame.size.width-2*mergin_left, 30);
}


//定义每一个cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake((self.frame.size.width-2*mergin_left-20)/3, 40);
}

//分类组
-(UIView *)setTableViewHeadViewWithTitle:(NSString *)title {
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 30)];
    headView.backgroundColor = WhiteColor;
    
    UILabel *lb_title = [[UILabel alloc] initWithFrame:CGRectMake(mergin_left, 10, self.frame.size.width-2*mergin_left, 20)];
    lb_title.text = title;
    lb_title.textColor = UIColorFromRGB(0x333333);
    lb_title.textAlignment = NSTextAlignmentLeft;
    lb_title.font = [UIFont systemFontOfSize:17];
    [headView addSubview:lb_title];
    
    return headView;
}

//选择类别
-(void)chooseCategoryItemWithIndexPath:(NSIndexPath *)indexpath {
    
    XECategoryGroupModel *group = [_dataSource objectAtIndex:indexpath.section];
    for (int i=0; i<group.category.count; i++) {
        XECategoryModel *cm = [group.category objectAtIndex:i];
        if (i==indexpath.row) {
            if (cm.isSelect) {
                cm.isSelect = NO;
            } else {
                cm.isSelect = YES;
            }
            [group.category replaceObjectAtIndex:i withObject:cm];
        }
    }
    [_collectionView reloadData];
}

#pragma mark - 重置
-(void)topBtnAction {
    
    for (int i=0; i<_dataSource.count; i++) {
        XECategoryGroupModel *group = _dataSource[i];
        for (XECategoryModel *model in group.category) {
            model.isSelect = NO;
        }
    }
    [_collectionView reloadData];
    
    _minTF.text = @"";
    _maxTF.text = @"";
}


-(void)selectData {
    
    NSMutableArray *_yearArr = [[NSMutableArray alloc] init];
    NSMutableArray *_carArr = [[NSMutableArray alloc] init];
    NSMutableArray *_brandnameArr = [[NSMutableArray alloc] init];
    NSMutableArray *_displacementArr = [[NSMutableArray alloc] init];
    NSMutableArray *_engineArr = [[NSMutableArray alloc] init];
    NSMutableArray *_gearboxArr = [[NSMutableArray alloc] init];
    NSMutableArray *_modelnameArr = [[NSMutableArray alloc] init];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    for (int i=0; i<_dataSource.count; i++) {
        XECategoryGroupModel *group = _dataSource[i];
        
        if ([group.title isEqualToString:@"年份"]) {
            [_yearArr addObjectsFromArray:[self retureSelectDataWithArray:group.category]];
        } else if ([group.title isEqualToString:@"车型"]) {
            [_carArr addObjectsFromArray:[self retureSelectDataWithArray:group.category]];
        }else if ([group.title isEqualToString:@"品牌"]) {
            [_brandnameArr addObjectsFromArray:[self retureSelectDataWithArray:group.category]];
        } else if ([group.title isEqualToString:@"排量"]) {
            [_displacementArr addObjectsFromArray:[self retureSelectDataWithArray:group.category]];
        } else if ([group.title isEqualToString:@"发动机型号"]) {
            [_engineArr addObjectsFromArray:[self retureSelectDataWithArray:group.category]];
        } else if ([group.title isEqualToString:@"波箱型号"]) {
            [_gearboxArr addObjectsFromArray:[self retureSelectDataWithArray:group.category]];
        } else if ([group.title isEqualToString:@"底盘型号"]) {
            [_modelnameArr addObjectsFromArray:[self retureSelectDataWithArray:group.category]];
        }
    }
    
    if (_yearArr.count) {
        [dict setObject:_yearArr forKey:@"years"];
    }
    if (_carArr.count) {
        [dict setObject:_carArr forKey:@"car"];
    }
    if (_brandnameArr.count) {
        [dict setObject:_brandnameArr forKey:@"brandname"];
    }
    if (_displacementArr.count) {
        [dict setObject:_displacementArr forKey:@"displacement"];
    }
    if (_engineArr.count) {
        [dict setObject:_engineArr forKey:@"engine"];
    }
    if (_gearboxArr.count) {
        [dict setObject:_gearboxArr forKey:@"gearbox"];
    }
    if (_modelnameArr.count) {
        [dict setObject:_modelnameArr forKey:@"modelname"];
    }
    if (_minTF.text.length) {
        int min = [_minTF.text intValue];
        [dict setObject:@(min) forKey:@"minNum"];
    }
    if (_maxTF.text.length) {
        int max = [_maxTF.text intValue];
        [dict setObject:@(max) forKey:@"maxNum"];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"brandFilter" object:self userInfo:dict];
}

-(NSArray *)retureSelectDataWithArray:(NSArray *)arr {
    
    NSMutableArray *mutaArr = [[NSMutableArray alloc] init];
    for (XECategoryModel *model in arr) {
        if (model.isSelect) {
            [mutaArr addObject:model.category];
        }
    }
    return mutaArr;
}


-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"brandFilterView" object:nil];
}


@end

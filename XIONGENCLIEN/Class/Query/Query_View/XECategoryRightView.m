//
//  XECategoryRightView.m
//  XIONGEN
//
//  Created by Ios on 2018/1/19.
//  Copyright © 2018年 Ios. All rights reserved.
//

#import "XECategoryRightView.h"
#import "XEBrandFilterCell.h"
#import "XECategoryGroupModel.h"
#import "XECategoryModel.h"

@interface XECategoryRightView () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray *selectArray;

@end

@implementation XECategoryRightView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _dataSource = [[NSMutableArray alloc] init];
        [self createCollectionVeiw];
    }
    return self;
}

#pragma mark --createCollectionVeiw
-(void)createCollectionVeiw {
    
    //此处必须要有创见一个UICollectionViewFlowLayout的对象
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    //同一行相邻两个cell的最小间距
    layout.minimumInteritemSpacing = 5;
    //最小两行之间的间距
    layout.minimumLineSpacing = 5;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight, kScreenWidth, kScreenHeight-SafeAreaTopHeight-SafeAreaBottomHeight) collectionViewLayout:layout];
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
    
    UICollectionReusableView *reusableView =nil;
    if (kind == UICollectionElementKindSectionHeader) {
        reusableView=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"headerView" forIndexPath:indexPath];
        [reusableView addSubview:[self setTableViewHeadView]];
    }
    return reusableView;
}

//每一个分组的上左下右间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

//头部试图的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(kScreenWidth-2*mergin_left, 30);
}

//定义每一个cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake((kScreenWidth-2*mergin_left-20)/3, 40);
}

//分类组
-(UIView *)setTableViewHeadView {
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    headView.backgroundColor = WhiteColor;
    
    UILabel *lb_title = [[UILabel alloc] initWithFrame:CGRectMake(mergin_left, 10, kScreenWidth-2*mergin_left, 20)];
    lb_title.text = @"大类";
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
            cm.isSelect = YES;
            [group.category replaceObjectAtIndex:i withObject:cm];
        }
    }
    [_collectionView reloadData];
}



@end

//
//  XE_HomeBtnView.m
//  XIONGEN
//
//  Created by Ios on 2018/1/18.
//  Copyright © 2018年 Ios. All rights reserved.
//

#import "XE_HomeBtnView.h"
#import "XEButtonsCell.h"

@interface XE_HomeBtnView () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray *datasource;

@end

@implementation XE_HomeBtnView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _datasource = [[NSMutableArray alloc] init];
        [self createCollectionVeiw];
    }
    return self;
}

#pragma mark --createCollectionVeiw
-(void)createCollectionVeiw {
    
    //此处必须要有创见一个UICollectionViewFlowLayout的对象
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    //同一行相邻两个cell的最小间距
    layout.minimumInteritemSpacing = 0;
    //最小两行之间的间距
    layout.minimumLineSpacing = 0;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.frame.size.height) collectionViewLayout:layout];
    _collectionView.backgroundColor = WhiteColor;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    layout.scrollDirection=UICollectionViewScrollDirectionVertical;
    [self addSubview:_collectionView];
    
    //这是cell的注册
    [_collectionView registerClass:[XEButtonsCell class] forCellWithReuseIdentifier:@"XEButtonsCell"];
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 1)];
    line.backgroundColor = LineColor;
    [self addSubview:line];
}

#pragma mark --collectionView delegate
//每一组有多少个cell
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _datasource.count;
}

//每一个cell是什么
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    XEButtonsCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"XEButtonsCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    [cell.homeButn setTitle:_datasource[indexPath.row] forState:UIControlStateNormal];
    switch (indexPath.row) {
        case 0:
            [cell.homeButn setImage:[UIImage imageWithContentsOfFile:ImagePath(@"home_message@2x")] forState:UIControlStateNormal];
            break;
        case 1:
            [cell.homeButn setImage:[UIImage imageWithContentsOfFile:ImagePath(@"home_friends@2x")] forState:UIControlStateNormal];
            break;
        case 2:
            [cell.homeButn setImage:[UIImage imageWithContentsOfFile:ImagePath(@"home_approved@2x")] forState:UIControlStateNormal];
            break;
        default:
            break;
    }
    
    return cell;
}

//定义每一个cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(kScreenWidth/3, 100);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.xeHomeBtnCallBack) {
        self.xeHomeBtnCallBack(indexPath.row+2);
    }
}

-(void)reloadViewWithData:(NSArray *)array {
    
    [_datasource addObjectsFromArray:array];
    [_collectionView reloadData];
}

-(void)layoutSubviews {
    _collectionView.frame = CGRectMake(0, 0, kScreenWidth, self.frame.size.height);
}

@end

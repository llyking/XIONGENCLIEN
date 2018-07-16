//
//  GetPhotoFromeCamaraVC.m
//  TianCi
//
//  Created by Ios on 2018/1/5.
//  Copyright © 2018年 Ios. All rights reserved.
//


#define kSizeThumbnailCollectionView  ([UIScreen mainScreen].bounds.size.width-20)/4

#import "GetPhotoFromeCamaraVC.h"
#import <Photos/Photos.h>
#import "MHPhotoBrowserController.h"
#import "LLYPhotoAsset.h"
#import "AssetsHelper.h"
#import "ChoosePhotoeCell.h"


@interface GetPhotoFromeCamaraVC () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,ChoosePhotoeCellDelegate>

@property (nonatomic,retain)UICollectionView            *myCo;
@property (nonatomic,retain)UICollectionView            *FullCollectionView;
@property (nonatomic,retain)UICollectionViewFlowLayout  *layout;

//存储图片信息的数组
@property (nonatomic,retain)NSMutableArray *assets;
//存储被选中的图片信息
@property (nonatomic,retain)NSMutableArray *selectedArray;
//图片是否选中数组
@property (nonatomic,retain)NSMutableArray *ImagesSelectedArray;

@end

@implementation GetPhotoFromeCamaraVC

static NSString *PhotoCellId = @"PhotosCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _assets                   = [[NSMutableArray alloc] init];
    _selectedArray            = [[NSMutableArray alloc] init];
    _ImagesSelectedArray      = [[NSMutableArray alloc] init];
    [self setNavigationBar];
    [self askForAuthorize];
    NSUserDefaults *firstPush = [NSUserDefaults standardUserDefaults];
    NSString  *firstStr = [firstPush objectForKey:@"firstPush"];
    if (firstStr) {
        [self getImages:NO];
        [self.view addSubview:self.myCo];
    }
    
}

#pragma mark - LazyLoad
- (UICollectionView *)myCo {
    if (!_myCo) {
        _layout =[[UICollectionViewFlowLayout alloc] init];
        _layout.minimumLineSpacing =2.0;
        _layout.minimumInteritemSpacing = 2.0;
        _layout.itemSize = CGSizeMake(kSizeThumbnailCollectionView, kSizeThumbnailCollectionView);
        _layout.sectionInset = UIEdgeInsetsMake(2, 2, 2, 2);
        _layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _layout.footerReferenceSize = CGSizeMake(kScreenWidth, 40);
        _myCo = [[UICollectionView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight, kScreenWidth, kScreenHeight-SafeAreaTopHeight-SafeAreaBottomHeight) collectionViewLayout:self.layout];
        _myCo.backgroundColor = [UIColor clearColor];
        [_myCo registerClass:[ChoosePhotoeCell class] forCellWithReuseIdentifier:PhotoCellId];
        _myCo.delegate = self;
        _myCo.dataSource = self;
        _myCo.tag = 1000;
        _myCo.showsHorizontalScrollIndicator = NO;
        _myCo.showsVerticalScrollIndicator = NO;
        
    }
    return _myCo;
}

-(void)setNavigationBar {
    self.Namelab.text = @"相册";
    UIButton *Btn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth-65, StatubarHeight, 50, 44)];
    [Btn setTitle:@"完成" forState:UIControlStateNormal];
    [Btn setTitleColor:WhiteColor forState:UIControlStateNormal];
    [Btn addTarget:self action:@selector(finishAction) forControlEvents:UIControlEventTouchUpInside];
    [Btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    Btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.topView addSubview:Btn];
}

#pragma mark - Delegate + Datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSLog(@"----%ld",self.assets.count);
    if (collectionView.tag == 1000) {
        return self.assets.count+1;
    }
    return self.assets.count;
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    NSLog(@"%ld",self.assets.count);
    return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ChoosePhotoeCell *cell= [collectionView dequeueReusableCellWithReuseIdentifier:PhotoCellId forIndexPath:indexPath];
    cell.checkBtn.tag = indexPath.row+100;
    cell.imageView.tag = indexPath.row;
    if (indexPath.row <self.assets.count) {
        PHAsset *asset = self.assets[indexPath.item];
        //传递图片资源信息
        [cell makeImageCell:asset takePhotos:nil];
        //传递图片是否被选中的状态信息
        [cell checkBtnIsSelected:self.ImagesSelectedArray[indexPath.item]];

    }else {
        [cell makeImageCell:nil takePhotos:@"Camaral"];
    }
    cell.delegate = self;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView.tag == 2000) {
        return CGSizeMake(kScreenWidth, kScreenHeight);
    }else {
        return CGSizeMake(kSizeThumbnailCollectionView, kSizeThumbnailCollectionView);
    }
}
//完成
-(void)finishAction {
    
    NSArray *imageCount = [self selectImages];
    if (self.isSingle==YES && imageCount.count>1) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"最多只能选一张图片";
        hud.margin = 10.f;
        hud.yOffset = 150.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1];
    } else {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"最多只能选6张图片";
        hud.margin = 10.f;
        hud.yOffset = 150.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1];
    }
    
    if (self.isSingle==YES&&imageCount.count<=1) {
        [self.navigationController popViewControllerAnimated:YES];
        [self.delegate getImagesArray:[self selectImages]];
    }
    
    if (self.isSingle==NO&&imageCount.count<=6) {
        [self.navigationController popViewControllerAnimated:YES];
        [self.delegate getImagesArray:[self selectImages]];
    }
}

#pragma mark -getImage
- (void)getImages:(BOOL)isFromTakePhoto {
    [_assets removeAllObjects];
    AssetsHelper *ImageAssets = [[AssetsHelper alloc] init];
    [_assets addObjectsFromArray:[ImageAssets getImageAssetSArray]];
    [_ImagesSelectedArray removeAllObjects];
    for (int i=0; i<_assets.count; i++) {
        [_ImagesSelectedArray addObject:@"0"];
    }
    if (isFromTakePhoto) {
        [_ImagesSelectedArray replaceObjectAtIndex:self.assets.count-1 withObject:@"1"];
        [self.selectedArray addObject:[self.assets lastObject]];
    }
    if (_assets.count > 0) {
        [self.myCo reloadData];
    }
}

//将选中的图片asset数组转换为image 数组
- (NSArray<UIImage *> *)selectImages {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    LLYPhotoAsset *assetObj = [[LLYPhotoAsset alloc] init];
    for (int i = 0; i < self.selectedArray.count; i++) {
        PHAsset *asset = self.selectedArray[i];
        UIImage *image = [assetObj OriginalImage:asset];
        [array addObject:image];
    }
    return array;
}

#pragma mark - SmallCellDelegate
- (void)pushIndex:(NSInteger)index {
    
    LLYPhotoAsset *assetObj = [[LLYPhotoAsset alloc] init];
    PHAsset *asset = self.assets[index];
    UIImage *image = [assetObj OriginalImage:asset];
    NSMutableArray * bigImgArray = [NSMutableArray new];
    [bigImgArray addObject:[MHPhotoModel photoWithImage:image]];
    MHPhotoBrowserController *vc = [MHPhotoBrowserController new];
    vc.displayTopPage = YES;
    vc.displayDeleteBtn = NO;
    vc.imgArray = bigImgArray;
    [self presentViewController:vc animated:NO completion:nil];
}

//根据SmallCell的点击改变checkBtn的选中状态
- (void)pushCheckBtnIndex:(NSInteger)index StatusString:(NSString *)statusStr {
    
    [self.ImagesSelectedArray replaceObjectAtIndex:index withObject:statusStr];
    if ([statusStr isEqualToString:@"1"]&&![self.selectedArray containsObject:self.assets[index]]) {
        [self.selectedArray addObject:self.assets[index]];
    }else{
        [self.selectedArray removeObject:self.assets[index]];
    }
}

- (void)askForAuthorize {
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status == PHAuthorizationStatusAuthorized) {
            NSUserDefaults *firstPush = [NSUserDefaults standardUserDefaults];
            NSString  *firstStr = [firstPush objectForKey:@"firstPush"];
            if (!firstStr) {
                dispatch_sync(dispatch_get_main_queue(), ^{
                    
                    [self getImages:NO];
                    [self.view addSubview:self.myCo];
                    [self setNavigationBar];
                    NSUserDefaults *firstPush = [NSUserDefaults standardUserDefaults];
                    [firstPush setObject:@"first" forKey:@"firstPush"];
                    
                });
                
            }
            NSLog(@"相册已授权打开");
        }else{
            NSLog(@"Denied or Restricted");
            dispatch_async(dispatch_get_main_queue(), ^{
                [self openAuthorization:@"相册权限未开启" message:@"相册权限未开启，请在设置中选择当前应用,开启相册功能"];
            });
        }
    }];
}

//判断是否开启了相册权限
- (void)openAuthorization:(NSString *)title message:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *open = [UIAlertAction actionWithTitle:@"立即开启" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction:open];
    [alert addAction:cancel];
    
    [self.navigationController presentViewController:alert animated:YES completion:nil];
    
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

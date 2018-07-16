//
//  ChangePhotoViewController.m
//  XIONGEN
//
//  Created by Ios on 2018/1/23.
//  Copyright © 2018年 Ios. All rights reserved.
//

#import "ChangePhotoViewController.h"
#import "GetPhotoFromeCamaraVC.h"

@interface ChangePhotoViewController () <UINavigationControllerDelegate,UIImagePickerControllerDelegate,GetPhotoFromeCamaraVCDelegate>
{
    BOOL _isphone;
    NSInteger p_back;
}

@property (nonatomic,strong) UIImageView *photoImageView;
@property (nonatomic,strong) UILabel *photoLab;

@property (nonatomic,strong) UIWindow *Window;//加载底图控制器
@property (nonatomic,strong) UIControl *controlWeekday;//设置输入框
@property (nonatomic,strong) UIView *bgView;

@end

@implementation ChangePhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.Namelab.text = @"个人头像";
    [self setPhotoView];
    WS(weakSelf)
    [self createRightBtnWithImageArray:@[@"my_icon_blue_dian@2x"] handle:^(NSInteger tag) {
        [weakSelf rightBtnClick];
    }];
}

#pragma mark -- view
-(void)setPhotoView {
    
    _photoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth/2-67, kScreenHeight/2-131, 134, 134)];
    _photoImageView.contentMode = UIViewContentModeScaleToFill;
    _photoImageView.layer.cornerRadius = 67;
    _photoImageView.layer.masksToBounds = YES;
    [self.view addSubview:_photoImageView];
}

-(void)rightBtnClick {
    [self tanKuang];
}

#pragma mark -- 拍照
-(void)tanKuang {
    
    _Window = [[UIApplication sharedApplication] windows].firstObject;
    
    _controlWeekday = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _controlWeekday.backgroundColor = UIColorFromRGBWithAlpha(0x000000,0.3);
    _controlWeekday.userInteractionEnabled = YES;
    [_Window addSubview:_controlWeekday];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidden)];
    [_controlWeekday addGestureRecognizer:tap];
    
    _bgView = [[UIView alloc] init];
    _bgView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 145);
    [_controlWeekday addSubview:_bgView];
    [UIView animateWithDuration:0.3f delay:0 usingSpringWithDamping:0.8f initialSpringVelocity:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        
        [_bgView setFrame: CGRectMake(0, kScreenHeight-SafeAreaBottomHeight-145, kScreenWidth, 145)];
        
    } completion:^(BOOL finished) {
        
    }];
    
    UIButton *takePhotoBtn = [[UIButton alloc] init];
    takePhotoBtn.frame = CGRectMake(0, 0, kScreenWidth, 45);
    takePhotoBtn.backgroundColor = [UIColor whiteColor];
    [takePhotoBtn setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
    [takePhotoBtn setTitle:@"拍照" forState:UIControlStateNormal];
    [takePhotoBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    takePhotoBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    takePhotoBtn.tag = 1;
    [takePhotoBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_bgView addSubview:takePhotoBtn];
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(takePhotoBtn.frame), kScreenWidth, 0.5)];
    line.backgroundColor = LineColor;
    [_bgView addSubview:line];
    
    
    UIButton *albumBtn = [[UIButton alloc] init];
    albumBtn.frame = CGRectMake(0, CGRectGetMaxY(line.frame), kScreenWidth, 45);
    albumBtn.backgroundColor = [UIColor whiteColor];
    [albumBtn setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
    [albumBtn setTitle:@"从手机相册选择" forState:UIControlStateNormal];
    [albumBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    albumBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    albumBtn.tag = 2;
    [albumBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_bgView addSubview:albumBtn];
    
    UILabel *line1 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(albumBtn.frame), kScreenWidth, 0.5)];
    line1.backgroundColor = LineColor;
    [_bgView addSubview:line1];
    
    
    UIButton *cancelBtn = [[UIButton alloc] init];
    cancelBtn.frame = CGRectMake(0, CGRectGetMaxY(albumBtn.frame)+10, kScreenWidth, 45);
    cancelBtn.backgroundColor = [UIColor whiteColor];
    [cancelBtn setTitleColor:ThemeColor forState:UIControlStateNormal];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    cancelBtn.tag = 4;
    [cancelBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_bgView addSubview:cancelBtn];
    
}

#pragma mark - 确定、取消
-(void)btnAction:(UIButton *)buton {
    
    switch (buton.tag) {
        case 1:
        {
            //拍照
            [UIView animateWithDuration:0.3f delay:0 usingSpringWithDamping:0.5f initialSpringVelocity:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
                
                _controlWeekday.backgroundColor = [UIColor clearColor];
                [_bgView setFrame: CGRectMake(0, kScreenHeight, kScreenWidth, 145)];
                
            } completion:^(BOOL finished) {
                
                UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
                imagePicker.delegate = self;
                imagePicker.allowsEditing = YES;
                if (imagePicker.sourceType != UIImagePickerControllerSourceTypeCamera) {
                    
                    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                    [self presentViewController:imagePicker animated:YES completion:nil];
                    [_controlWeekday removeFromSuperview];
                    
                } else {
                    
                    UIAlertController *alertc = [UIAlertController alertControllerWithTitle:@"请开启允许该项目拍照的按钮" message:@"" preferredStyle:UIAlertControllerStyleAlert];
                    
                    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        
                    }];
                    [alertc addAction:action1];
                    [self presentViewController:alertc animated:YES completion:nil];
                }
                
            }];
        }
            break;
        case 2:
        {
            //从手机相册选择
            [UIView animateWithDuration:0.3f delay:0 usingSpringWithDamping:0.5f initialSpringVelocity:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
                
                _controlWeekday.backgroundColor = [UIColor clearColor];
                [_bgView setFrame: CGRectMake(0, kScreenHeight, kScreenWidth, 145)];
                
            } completion:^(BOOL finished) {
                GetPhotoFromeCamaraVC *camara = [[GetPhotoFromeCamaraVC alloc]init];
                camara.isSingle = YES;
                camara.delegate = self;
                [self.navigationController pushViewController:camara animated:YES];
                
            }];
            [self hidden];
        }
            break;
        case 4:
        {
            //取消
            [self hidden];
        }
            break;
            
        default:
            break;
    }
}

-(void)hidden {
    [UIView animateWithDuration:0.3f delay:0 usingSpringWithDamping:0.8f initialSpringVelocity:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        _controlWeekday.backgroundColor = [UIColor clearColor];
        [_bgView setFrame: CGRectMake(0, kScreenHeight, kScreenWidth, 145)];
        
    } completion:^(BOOL finished) {
        
        [_controlWeekday removeFromSuperview];
    }];
}

#pragma mark ----------UIImagePickerController Delegate---------
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *img = [info objectForKey:UIImagePickerControllerEditedImage];
    [self performSelector:@selector(saveImage:)  withObject:img afterDelay:0.5];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)saveImage:(UIImage *)image {
    
    [_photoImageView setImage:image];
    _isphone = YES;
}

// 指定回调方法
- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo{
    
    NSString *msg = nil ;
    if(error != NULL){
        msg = @"保存图片失败" ;
    }else{
        msg = @"保存图片成功" ;
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"保存图片结果提示"
                                                    message:msg
                                                   delegate:self
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
}



-(void)backButtonBar {
    
    if (p_back == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else{
        
        if (_isphone) {
            
            if (_changeImageBlock) {
                _changeImageBlock(_photoImageView.image);
            }
            [self.navigationController popViewControllerAnimated:YES];
        }
        else{
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }
        
    }
}

#pragma mark - PhotosControllerDelegate 方法（通过该数组可获得选中的UIImage 信息数组）
- (void)getImagesArray:(NSArray<UIImage *> *)imagesArray {
    NSLog(@"图片：%ld",imagesArray.count);
    if (imagesArray.count!=0) {
        [_photoImageView setImage:imagesArray.firstObject];
        _isphone = YES;
    }
}





@end

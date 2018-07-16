//
//  AlterListView.m
//  XIONGEN
//
//  Created by Ios on 2018/1/31.
//  Copyright © 2018年 Ios. All rights reserved.
//

#import "AlterListView.h"
#import "GetPhotoFromeCamaraVC.h"
#import "AlterModel.h"

@interface AlterListView () <UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,GetPhotoFromeCamaraVCDelegate>
{
    NSString *selectItem;
    NSMutableArray *mutaArr;
    BOOL Single;
    BOOL nothingCancel;
    UIViewController *showVC;
}

@property (nonatomic,strong) UIButton *cancelBtn;
@property (nonatomic,strong) UILabel *titleLab;
@property (nonatomic,strong) UIView *bottomView;
@property (nonatomic,strong) UITableView *listTableView;
@property (nonatomic,strong) NSMutableArray *listData;
@property (nonatomic,copy) NSString *title;

@property(nonatomic,strong)UIWindow *Window;//加载底图控制器
@property(nonatomic,strong)UIControl *controlWeekday;//设置输入框

@end

@implementation AlterListView

+(instancetype)shareAlterView {
    static AlterListView *shareAlterView = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareAlterView = [[AlterListView alloc] init];
        
    });
    return shareAlterView;
}

-(void)initAlterViewWithTitleString:(NSString *)title andDataArray:(NSArray *)dataArray andSelectType:(BOOL)isSingle{
    
    _listData = [[NSMutableArray alloc] init];
    _title = title;
    selectItem = @"";
    Single = isSingle;
    nothingCancel = YES;
    mutaArr = [[NSMutableArray alloc] init];
    [_listData addObjectsFromArray:dataArray];
    
    [self popView];
    [self createBottomView];
    [self show];
}

-(void)popView {
    
    _Window = [[UIApplication sharedApplication] windows].firstObject;
    
    _controlWeekday = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _controlWeekday.backgroundColor = UIColorFromRGBWithAlpha(0x000000,0.5);
    _controlWeekday.userInteractionEnabled = YES;
    [_Window addSubview:_controlWeekday];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
    tap.delegate = self;
    [_controlWeekday addGestureRecognizer:tap];
}

-(void)createBottomView {
    
    _bottomView = [[UIView alloc] initWithFrame:CGRectZero];
    _bottomView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 200);
    _bottomView.userInteractionEnabled = YES;
    [_controlWeekday addSubview:_bottomView];
    
    UIButton *cancel = [UIButton buttonWithType:UIButtonTypeCustom];
    cancel.frame = CGRectMake(0, 0, 50, 40);
    [cancel setTitle:@"取消" forState:UIControlStateNormal];
    [cancel setTitleColor:WhiteColor forState:UIControlStateNormal];
    cancel.titleLabel.font = LSYUIFont(15);
    cancel.backgroundColor = ThemeColor;
    cancel.tag = 0;
    [cancel addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:cancel];
    
    _titleLab = [[UILabel alloc] init];
    _titleLab.frame = CGRectMake(CGRectGetMaxX(cancel.frame), 0, _bottomView.frame.size.width-100, 40);
    _titleLab.textColor = WhiteColor;
    _titleLab.textAlignment = NSTextAlignmentCenter;
    _titleLab.font = LSYUIFont(15);
    _titleLab.backgroundColor = ThemeColor;
    _titleLab.text = _title;
    [_bottomView addSubview:_titleLab];
    
    UIButton *sure = [UIButton buttonWithType:UIButtonTypeCustom];
    sure.frame = CGRectMake(CGRectGetMaxX(_titleLab.frame), 0, 50, 40);
    [sure setTitle:@"确定" forState:UIControlStateNormal];
    [sure setTitleColor:WhiteColor forState:UIControlStateNormal];
    sure.titleLabel.font = LSYUIFont(15);
    sure.backgroundColor = ThemeColor;
    sure.tag = 1;
    [sure addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:sure];
    
    UILabel *line = [[UILabel alloc] init];
    line.frame = CGRectMake(0, CGRectGetMaxY(sure.frame), _bottomView.frame.size.width, 1);
    line.backgroundColor = LineColor;
    [_bottomView addSubview:line];
    
    
    _listTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _listTableView.frame = CGRectMake(0, CGRectGetMaxY(line.frame), _bottomView.frame.size.width, 160);
    _listTableView.delegate = self;
    _listTableView.dataSource = self;
    [_bottomView addSubview:_listTableView];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _listData.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"tableCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    AlterModel *model = _listData[indexPath.row];
    cell.textLabel.text = model.name;
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    cell.textLabel.font = LSYUIFont(15);
    
    if (model.select) {
        cell.textLabel.textColor = ThemeColor;
    } else {
        cell.textLabel.textColor = UIColorFromRGB(0x333333);
    }
    cell.userInteractionEnabled = YES;
    cell.tag = indexPath.row;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectItem:)];
    [cell addGestureRecognizer:tap];
    
    return cell;
}

-(void)selectItem:(UITapGestureRecognizer *)tap {
    
    NSInteger row = tap.view.tag;
    AlterModel *model = _listData[row];
    if (model.isSingle) {
        for (int i=0; i<_listData.count; i++) {
            AlterModel *model = _listData[i];
            if (i==row) {
                model.select = YES;
            } else {
                model.select = NO;
            }
        }
    } else {
        for (int i=0; i<_listData.count; i++) {
            AlterModel *model = _listData[i];
            if (model.select) {
                if (i==row) {
                    model.select = NO;
                }
            } else {
                if (i==row) {
                    model.select = YES;
                }
            }
        }
    }
    [_listTableView reloadData];
}

#pragma mark-手势代理，解决和tableview点击发生的冲突
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {//判断如果点击的是tableView的cell，就把手势给关闭了
        return NO;//关闭手势
    } else if ([NSStringFromClass([touch.view class]) isEqualToString:@"UIButton"]) {
        return NO;
    }
    //否则手势存在
    return YES;
}

-(void)buttonAction:(UIButton *)butn {
    
    switch (butn.tag) {
        case 0:
        {
            nothingCancel = YES;
        }
            break;
        case 1:
        {
            nothingCancel = NO;
        }
            break;
        default:
            break;
    }
    [self hide];
}


-(void)show {
    
    [UIView animateWithDuration:0.5 animations:^{
        _bottomView.frame = CGRectMake(0, kScreenHeight-200, kScreenWidth, 200);
    } completion:^(BOOL finished) {
        
    }];
}

-(void)hide {
    
    if (nothingCancel) {
        
        [UIView animateWithDuration:0.5 animations:^{
            _controlWeekday.backgroundColor = [UIColor clearColor];
            _bottomView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 200);
        } completion:^(BOOL finished) {
            
            [_controlWeekday removeFromSuperview];
        }];
        
    } else {
        
        for (int i=0; i<_listData.count; i++) {
            AlterModel *model = _listData[i];
            if (model.select) {
                [mutaArr addObject:model.name];
            }
        }
        selectItem = [mutaArr componentsJoinedByString:@","];
        NSLog(@"selectItem:%@",selectItem);
        [UIView animateWithDuration:0.5 animations:^{
            _controlWeekday.backgroundColor = [UIColor clearColor];
            _bottomView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 200);
        } completion:^(BOOL finished) {
            
            if (selectItem.length>0) {
                if (self.backWithString) {
                    self.backWithString(selectItem);
                }
            }
            [_controlWeekday removeFromSuperview];
        }];
    }
    
}


#pragma mark - 图片来源弹框
-(void)initAlterPhotoViewWithController:(UIViewController *)controller {
    nothingCancel = YES;
    showVC = controller;
    [self popView];
    [self createPhotoView];
}

-(void)createPhotoView {
    _bottomView = [[UIView alloc] initWithFrame:CGRectZero];
    _bottomView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 145);
    _bottomView.userInteractionEnabled = YES;
    [_controlWeekday addSubview:_bottomView];
    
    [UIView animateWithDuration:0.5 animations:^{
        _bottomView.frame = CGRectMake(0, kScreenHeight-145, kScreenWidth, 145);
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
    [_bottomView addSubview:takePhotoBtn];
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(takePhotoBtn.frame), kScreenWidth, 0.5)];
    line.backgroundColor = LineColor;
    [_bottomView addSubview:line];
    
    
    UIButton *albumBtn = [[UIButton alloc] init];
    albumBtn.frame = CGRectMake(0, CGRectGetMaxY(line.frame), kScreenWidth, 45);
    albumBtn.backgroundColor = [UIColor whiteColor];
    [albumBtn setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
    [albumBtn setTitle:@"从手机相册选择" forState:UIControlStateNormal];
    [albumBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    albumBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    albumBtn.tag = 2;
    [albumBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:albumBtn];
    
    UILabel *line1 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(albumBtn.frame), kScreenWidth, 0.5)];
    line1.backgroundColor = LineColor;
    [_bottomView addSubview:line1];
    
    
    UIButton *cancelBtn = [[UIButton alloc] init];
    cancelBtn.frame = CGRectMake(0, CGRectGetMaxY(albumBtn.frame)+10, kScreenWidth, 45);
    cancelBtn.backgroundColor = [UIColor whiteColor];
    [cancelBtn setTitleColor:ThemeColor forState:UIControlStateNormal];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    cancelBtn.tag = 4;
    [cancelBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:cancelBtn];
}

#pragma mark - 确定、取消
-(void)btnAction:(UIButton *)buton {
    
    switch (buton.tag) {
        case 1:
        {
            //拍照
            [UIView animateWithDuration:0.3f delay:0 usingSpringWithDamping:0.5f initialSpringVelocity:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
                
                _controlWeekday.backgroundColor = [UIColor clearColor];
                [_bottomView setFrame: CGRectMake(0, kScreenHeight, kScreenWidth, 145)];
                
            } completion:^(BOOL finished) {
                
                UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
                imagePicker.delegate = self;
                imagePicker.allowsEditing = YES;
                if (imagePicker.sourceType != UIImagePickerControllerSourceTypeCamera) {
                    
                    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                    [showVC presentViewController:imagePicker animated:YES completion:nil];
                    [_controlWeekday removeFromSuperview];
                    
                } else {
                    
                    UIAlertController *alertc = [UIAlertController alertControllerWithTitle:@"请开启允许该项目拍照的按钮" message:@"" preferredStyle:UIAlertControllerStyleAlert];
                    
                    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        
                    }];
                    [alertc addAction:action1];
                    [showVC presentViewController:alertc animated:YES completion:nil];
                }
                
            }];
        }
            break;
        case 2:
        {
            //从手机相册选择
            [UIView animateWithDuration:0.3f delay:0 usingSpringWithDamping:0.5f initialSpringVelocity:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
                
                _controlWeekday.backgroundColor = [UIColor clearColor];
                [_bottomView setFrame: CGRectMake(0, kScreenHeight, kScreenWidth, 145)];
                
            } completion:^(BOOL finished) {
                GetPhotoFromeCamaraVC *camara = [[GetPhotoFromeCamaraVC alloc]init];
                camara.isSingle = YES;
                camara.delegate = self;
                [showVC.navigationController pushViewController:camara animated:YES];
                
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
        [_bottomView setFrame: CGRectMake(0, kScreenHeight, kScreenWidth, 145)];
        
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
    if (self.backImage) {
        self.backImage(image);
    }
}

#pragma mark - PhotosControllerDelegate 方法（通过该数组可获得选中的UIImage 信息数组）
- (void)getImagesArray:(NSArray<UIImage *> *)imagesArray {
    NSLog(@"图片：%ld",imagesArray.count);
    if (imagesArray.count!=0) {
        if (self.backImage) {
            self.backImage(imagesArray.firstObject);
        }
    }
}


@end

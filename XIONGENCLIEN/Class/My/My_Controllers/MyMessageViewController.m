//
//  MyMessageViewController.m
//  XIONGEN
//
//  Created by Ios on 2018/1/23.
//  Copyright © 2018年 Ios. All rights reserved.
//

#import "MyMessageViewController.h"
//#import "ChangeNameViewController.h"
#import "ChangePhoneViewController.h"
#import "ChangePhotoViewController.h"
#import "AlterListView.h"

@interface MyMessageViewController ()

@property (nonatomic,strong) UIImageView *photoImg;
@property (nonatomic,strong) BroughtButton *btnusername;
@property (nonatomic,strong) BroughtButton *btnname;
@property (nonatomic,strong) BroughtButton *btndepartment;
@property (nonatomic,strong) BroughtButton *btnphone;
@property (nonatomic,strong) BroughtButton *btnregisttime;

@end

@implementation MyMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.Namelab.text = @"个人信息";
    self.topScrollerView.backgroundColor = UIColorFromRGB(0xf6f6f6);
    [self createUIView];
}

-(void)createUIView {
    UIView *photoView = [self setPhotoViewWithFrame:CGRectMake(0, 0, kScreenWidth, 60)];
    photoView.backgroundColor = WhiteColor;
    [self.topScrollerView addSubview:photoView];
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(photoView.frame), kScreenWidth, 1)];
    line.backgroundColor = LineColor;
    [self.topScrollerView addSubview:line];
    
    if (!_btnusername) {
        _btnusername = [[BroughtButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(line.frame), kScreenWidth, 45)];
        _btnusername.left_imgV.hidden = YES;
        _btnusername.left_lab.frame = CGRectMake(15, 0, 100, 45);
        _btnusername.left_lab.text = @"用户名";
        [self.topScrollerView addSubview:_btnusername];
    }
    
    if (!_btnname) {
        _btnname = [[BroughtButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_btnusername.frame), kScreenWidth, 45)];
        _btnname.left_imgV.hidden = YES;
        _btnname.right_imgV.hidden = YES;
        _btnname.left_lab.frame = CGRectMake(15, 0, 100, 45);
        _btnname.left_lab.text = @"姓名";
        [self.topScrollerView addSubview:_btnname];
    }
    
    if (!_btndepartment) {
        _btndepartment = [[BroughtButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_btnname.frame), kScreenWidth, 45)];
        _btndepartment.left_imgV.hidden = YES;
        _btndepartment.right_imgV.hidden = YES;
        _btndepartment.left_lab.frame = CGRectMake(15, 0, 100, 45);
        _btndepartment.left_lab.text = @"部门";
        [self.topScrollerView addSubview:_btndepartment];
    }
    
    if (!_btnphone) {
        _btnphone = [[BroughtButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_btndepartment.frame), kScreenWidth, 45)];
        _btnphone.left_imgV.hidden = YES;
        _btnphone.left_lab.frame = CGRectMake(15, 0, 100, 45);
        _btnphone.left_lab.text = @"手机号";
        _btnphone.tag = 2;
        [_btnphone addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.topScrollerView addSubview:_btnphone];
    }
    
    if (!_btnregisttime) {
        _btnregisttime = [[BroughtButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_btnphone.frame), kScreenWidth, 45)];
        _btnregisttime.left_imgV.hidden = YES;
        _btnregisttime.right_imgV.hidden = YES;
        _btnregisttime.left_lab.frame = CGRectMake(15, 0, 100, 45);
        _btnregisttime.left_lab.text = @"注册时间";
        [self.topScrollerView addSubview:_btnregisttime];
    }
    self.topScrollerView.contentSize = CGSizeMake(kScreenWidth, CGRectGetMaxY(_btnregisttime.frame)+50);
}

#pragma mark -- 头像
-(UIView *)setPhotoViewWithFrame:(CGRect) frame {
    
    UIView *photoV = [[UIView alloc] initWithFrame:frame];
    photoV.userInteractionEnabled = YES;
    photoV.backgroundColor = WhiteColor;
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 100, frame.size.height)];
    lab.text = @"头像";
    lab.textAlignment = NSTextAlignmentLeft;
    lab.textColor = UIColorFromRGB(0x666666);
    lab.font = [UIFont systemFontOfSize:15];
    [photoV addSubview:lab];
    
    UIImageView *right_imgV = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width - 23, (frame.size.height - 14)/2, 8, 14)];
    right_imgV.image = [UIImage imageNamed:@"home_icon_more@2x"];
    [photoV addSubview:right_imgV];
    
    
    _photoImg = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(right_imgV.frame)-50, 10, 40, 40)];
    _photoImg.layer.cornerRadius = 20;
    _photoImg.layer.masksToBounds = YES;
    _photoImg.userInteractionEnabled = YES;
    _photoImg.contentMode = UIViewContentModeScaleToFill;
    [_photoImg sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@""]];
    [photoV addSubview:_photoImg];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ImagePress)];
    [photoV addGestureRecognizer:tap];
    
    return photoV;
}

-(void)btnAction:(UIButton *)btn {
     WS(weakSelf)
    switch (btn.tag) {
        case 1:
        {
            //修改用户名
//            ChangeNameViewController *name = [[ChangeNameViewController alloc] init];
//            [self.navigationController pushViewController:name animated:YES];
//
//            [name setChangeNameBlock:^(NSString *name) {
//                weakSelf.btnusername.right_lab.text = name;
//            }];
        }
            break;
        case 2:
        {
            //修改手机号
            ChangePhoneViewController *phone = [[ChangePhoneViewController alloc] init];
            [self.navigationController pushViewController:phone animated:YES];
            
            [phone setChangePhoneBlock:^(NSString *phone) {
                weakSelf.btnphone.right_lab.text = phone;
            }];
        }
            break;
        default:
            break;
    }
}

-(void)ImagePress {
    WS(weakSelf)
    AlterListView *alterV = [AlterListView shareAlterView];
    [alterV initAlterPhotoViewWithController:self];
    [alterV setBackImage:^(UIImage *image) {
        [weakSelf changeHeadImgWithImage:image];
    }];
}

-(void)loadViewWithData:(UserInfoModel *)model {
        
    _btnusername.right_lab.text = model.account;
    _btnname.right_lab.text = model.username;
    _btndepartment.right_lab.text = model.deptName;
    _btnphone.right_lab.text = model.phone;
    _btnregisttime.right_lab.text = model.createdate;
    [_photoImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseURL,model.img]] placeholderImage:nil];
    
}

-(void)changeHeadImgWithImage:(UIImage *)imge {
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:FID,@"fid", nil];
    WS(weakSelf)
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"application/x-www-form-urlencoded",nil];
    
    [manager POST:[NSString stringWithFormat:@"%@%@",BaseURL,@"back/system/changeHeadImg.do"] parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        //使用日期生成图片名称
        NSInteger imgCount = 0;
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSData *data = UIImageJPEGRepresentation(imge, 0.5);
        NSString *fileName = [NSString stringWithFormat:@"%@%@.png",[formatter stringFromDate:[NSDate date]],@(imgCount)];
        [formData appendPartWithFileData:data name:@"photo" fileName:fileName mimeType:@"image/png"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //上传图片成功执行回调
        if ([[NSString stringWithFormat:@"%@",responseObject[@"success"]] isEqualToString:@"1"] && [[NSString stringWithFormat:@"%@",responseObject[@"errcode"]] isEqualToString:@"0"]) {
            [SVProgressHUD showSuccessWithStatus:responseObject[@"message"]];
            weakSelf.photoImg.image = imge;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:@"changePhoto" object:self userInfo:[responseObject objectForKey:@"data"]];
            });
        } else {
            [SVProgressHUD showErrorWithStatus:responseObject[@"message"]];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //上传图片失败执行回调
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:@"修改失败"];
    }];
}


@end

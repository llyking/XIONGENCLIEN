//
//  XE_HomeMainView.m
//  XIONGEN
//
//  Created by Ios on 2018/1/17.
//  Copyright © 2018年 Ios. All rights reserved.
//

#import "XE_HomeMainView.h"


@interface XE_HomeMainView () {
    NSArray *_leftTitleArr;
}

@property (nonatomic,strong) UIView *headVeiw;
@property (nonatomic,strong) UIView *btnView;
@property (nonatomic,strong) UIScrollView *mainScrollView;

@end


@implementation XE_HomeMainView


-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initLeftTitleArrWithType:_type];
        [self addSubview:_headVeiw];
        [self addSubview:_mainScrollView];
    }
    return self;
}

-(void)initLeftTitleArrWithType:(NSInteger)type {
    
    switch (type) {
        case XE_Role_Manager:
        {
            _leftTitleArr = @[@"所有业务员当月销售额:",@"所有业务员本年销售额:",
                              @"所有采购员当月采购额:",@"所有采购员本年采购额:",
                              @"所有财务员当月应收款:",@"所有财务员当月应付款:",
                              @"所有财务员本年应收款:",@"所有财务员本年应付款:"];
        }
            break;
        case XE_Role_Salesman:
        {
            _leftTitleArr = @[@"当月销售额:",@"本年销售额:",@"完成率:"];
        }
            break;
        case XE_Role_Buyer:
        {
            _leftTitleArr = @[@"本月采购金额:",@"本年采购金额:"];
        }
            break;
        case XE_Role_Customer:
        {
            _leftTitleArr = @[@"当月采购额:"];
        }
            break;
        case XE_Role_Personnel:
        {
            _leftTitleArr = @[];
        }
            break;
        case XE_Role_Stream:
        {
            _leftTitleArr = @[@"打包数:",@"提货数:",@"发货数:"];
        }
            break;
        default:
            break;
    }
}

-(void)setBtnTypeArr:(NSArray *)btnTypeArr {
    
    WS(weakSelf)
    CGFloat buttonWidth = ceilf(kScreenWidth / 2);
    CGFloat buttonHeigt = 30;
    [_leftTitleArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSInteger row = idx / 2;
        NSUInteger col = idx % 2;
        XERoleType btnType = idx;
        
        UIButton *mineBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [mineBtn setContentHorizontalAlignment:(UIControlContentHorizontalAlignmentCenter)];
        [mineBtn setTitle:[NSString stringWithFormat:@"%@%@",obj,btnTypeArr[idx]] forState:UIControlStateNormal];
        [mineBtn setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
        [[mineBtn titleLabel] setFont: LSYUIFont(15)];
        [mineBtn setTag:btnType];
        [_btnView addSubview:mineBtn];
        
        [mineBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.btnView.mas_top).offset(row *buttonHeigt + 2);
            if (idx == 4) {
                make.width.mas_equalTo(buttonWidth + 12);
                make.left.mas_equalTo(weakSelf.btnView.mas_left).offset(col *buttonWidth - 6);
            }else if (idx == 1){
                make.width.mas_equalTo(buttonWidth + 26);
                make.left.mas_equalTo(weakSelf.btnView.mas_left).offset(col *buttonWidth - 13);
            }else{
                make.width.mas_equalTo(buttonWidth);
                make.left.mas_equalTo(weakSelf.btnView.mas_left).offset(col *buttonWidth);
            }
            make.height.mas_equalTo(buttonHeigt);
        }];
    }];
    [_mainScrollView addSubview:_btnView];
    
}

-(UIView *)headVeiw {
    
    if (!_headVeiw) {
        _headVeiw = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, SafeAreaTopHeight)];
        _headVeiw.backgroundColor = UIColorFromRGB(0x2e38a7);
        _headVeiw.userInteractionEnabled = YES;
        
        UILabel *lb_title = [[UILabel alloc] initWithFrame:CGRectMake(0, StatubarHeight, kScreenWidth, NavigtionHeight)];
        lb_title.text = @"雄恩贸易";
        lb_title.textColor = WhiteColor;
        lb_title.textAlignment = NSTextAlignmentCenter;
        lb_title.font = LSYUIFont(17);
        [_headVeiw addSubview:lb_title];
        
        UIButton *btn_scan = [[UIButton alloc] initWithFrame:CGRectMake(mergin_left, StatubarHeight+(NavigtionHeight-30)/2, 30, 30)];
        [btn_scan setBackgroundImage:HKFastImage(@"") forState:UIControlStateNormal];
        btn_scan.tag = XEHomeTopScanBtnType;
        [btn_scan addTarget:self action:@selector(topBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_headVeiw addSubview:btn_scan];
        
        UIButton *btn_my = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width-2*mergin_left-30, StatubarHeight+(NavigtionHeight-30)/2, 30, 30)];
        [btn_my setBackgroundImage:HKFastImage(@"") forState:UIControlStateNormal];
        btn_my.tag = XEHomeTopMyBtnType;
        [btn_my addTarget:self action:@selector(topBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_headVeiw addSubview:btn_my];
    }
    return _headVeiw;
}

-(UIScrollView *)mainScrollView {
    
    if (!_mainScrollView) {
        _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headVeiw.frame), kScreenWidth, kScreenHeight-SafeAreaTopHeight-TabbarHeight)];
//        _mainScrollView.delegate = self;
        _mainScrollView.showsVerticalScrollIndicator = NO;
        _mainScrollView.backgroundColor = WhiteColor;
    }
    return _mainScrollView;
}

-(UIView *)btnView {
    
    if (!_btnView) {
        _btnView = [[UIView alloc] initWithFrame:CGRectMake(0, 180, kScreenWidth, 190)];
        [_btnView setBackgroundColor:WhiteColor];
    }
    return _btnView;
}

- (void)topBtnAction:(UIButton *)sender {
    XEBtnType btnType = sender.tag;
    if (self.xeHomeHeadViewBtnCallBack) {
        self.xeHomeHeadViewBtnCallBack(btnType);
    }
}



@end

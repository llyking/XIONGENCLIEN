//
//  XEComboBox.m
//  XIONGEN
//
//  Created by Ios on 2018/1/20.
//  Copyright © 2018年 Ios. All rights reserved.
//

#import "XEComboBox.h"

@interface XEComboBox () <UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>
{
    CGRect selfFrame;
    BOOL _isAnimation;
}

@property (nonatomic,strong) NSMutableArray *data;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIWindow *Window;//加载底图控制器
@property (nonatomic,strong) UIView *bgView;
@property(nonatomic,strong)UIControl *controlWeekday;//设置输入框

@end

@implementation XEComboBox

+(instancetype)shareXEComboBox {
    static XEComboBox *shareAlterView = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareAlterView = [[XEComboBox alloc] init];
    });
    return shareAlterView;
}

-(void)initXEComboBoxWithDataArray:(NSArray *)dataArray andFrame:(CGRect)frame isAnimation:(BOOL)isAnimation {
    
    _isAnimation = isAnimation;
    _data = [[NSMutableArray alloc] init];
    [_data addObjectsFromArray:dataArray];
    
    selfFrame = frame;
    [self createView];
    if (_isAnimation) {
        [self show];
    }
}

-(void)createView {
    
    _Window = [[UIApplication sharedApplication] windows].firstObject;
    _Window.userInteractionEnabled = YES;
    
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _bgView.backgroundColor = [UIColor clearColor];
    _bgView.userInteractionEnabled = YES;
    [_Window addSubview:_bgView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiden)];
    tap.delegate = self;
    [_bgView addGestureRecognizer:tap];
    
    _tableView = [[UITableView alloc] init];
    _tableView.frame = selfFrame;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_bgView addSubview:_tableView];
    
    if (_isAnimation) {
        _tableView.frame = CGRectMake(0, 0, selfFrame.size.width, selfFrame.size.height);
        _tableView.layer.position = CGPointMake(kScreenWidth-10, SafeAreaTopHeight);
        _tableView.layer.anchorPoint = CGPointMake(1,0);
    }
}


#pragma mark-手势代理，解决和tableview点击发生的冲突
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    NSLog(@"%@", NSStringFromClass([touch.view class]));
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {//判断如果点击的是tableView的cell，就把手势给关闭了
        return NO;//关闭手势
    }
    return YES;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _data.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"comboBox"];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"comboBox"];
    }
    cell.backgroundColor = UIColorFromRGB(0xf6f6f6);
    cell.textLabel.text = _data[indexPath.row];
    cell.textLabel.textColor = UIColorFromRGB(0x333333);
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.font = LSYUIFont(15);
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.XEFollowOrderStatusBack) {
        
        self.XEFollowOrderStatusBack(_data[indexPath.row]);
    }
    [self hiden];
}


-(void)show {
    [self animationSpread:_tableView];
}

-(void)hiden {
    
    _bgView.backgroundColor = [UIColor clearColor];
    [_bgView removeFromSuperview];
    
    if (_isAnimation) {
        [self animationBack:_tableView];
    }
}


- (void)animationSpread:(UIView*)view {
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0, 0, 1)];
    scaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1)];
    scaleAnimation.duration = 1.5;
    scaleAnimation.cumulative = NO;
    scaleAnimation.repeatCount = 1;
    [scaleAnimation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    view.layer.transform = CATransform3DMakeScale(1, 1, 1);//当动画完成后，保持现状
    [view.layer addAnimation: scaleAnimation forKey:@"myScale"];
}

- (void)animationBack:(UIView*)view {
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1)];
    scaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0, 0, 1)];
    scaleAnimation.duration = 1.5;
    scaleAnimation.cumulative = NO;
    scaleAnimation.repeatCount = 1;
    [scaleAnimation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    view.layer.transform = CATransform3DMakeScale(0, 0, 1);
    [view.layer addAnimation: scaleAnimation forKey:@"myScale"];
}



@end

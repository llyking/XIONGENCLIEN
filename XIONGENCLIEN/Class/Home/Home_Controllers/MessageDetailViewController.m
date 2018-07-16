//
//  MessageDetailViewController.m
//  XIONGEN
//
//  Created by Ios on 2018/1/22.
//  Copyright © 2018年 Ios. All rights reserved.
//

#import "MessageDetailViewController.h"

@interface MessageDetailViewController ()

@property (nonatomic,strong) UILabel *date;
@property (nonatomic,strong) UILabel *sender;
@property (nonatomic,strong) UITextView *textV;

@end

@implementation MessageDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.Namelab.text = @"消息详情";
    [self creatui];
}

-(void)creatui {
    
    if (!_date) {
        _date = [[UILabel alloc] init];
        _date.frame = CGRectMake(mergin_left, 20, kScreenWidth-2*mergin_left, 20);
        _date.textColor = UIColorFromRGB(0x333333);
        _date.textAlignment = NSTextAlignmentLeft;
        _date.font = LSYUIFont(15);
        _date.text = @"日期:2018-01-13";
        [self.topScrollerView addSubview:_date];
    }
    
    if (!_sender) {
        _sender = [[UILabel alloc] init];
        _sender.frame = CGRectMake(mergin_left, CGRectGetMaxY(_date.frame)+20, kScreenWidth-2*mergin_left, 20);
        _sender.textColor = UIColorFromRGB(0x333333);
        _sender.textAlignment = NSTextAlignmentLeft;
        _sender.font = LSYUIFont(15);
        _sender.text = @"发送人:小明";
        [self.topScrollerView addSubview:_sender];
    }
    
    if (!_textV) {
        _textV = [[UITextView alloc] init];
        _textV.frame = CGRectMake(mergin_left, CGRectGetMaxY(_sender.frame)+20, kScreenWidth-2*mergin_left, 50);
        _textV.textColor = UIColorFromRGB(0x333333);
        _textV.textAlignment = NSTextAlignmentLeft;
        _textV.font = LSYUIFont(15);
        _textV.text = @"内容:";
        [self.topScrollerView addSubview:_textV];
    }
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithAttributedString:_textV.attributedText];
    
    NSTextAttachment *textAttachment = [[NSTextAttachment alloc] initWithData:nil ofType:nil] ;
    textAttachment.image = [UIImage imageNamed:@"111"]; //要添加的图片
    NSAttributedString *textAttachmentString = [NSAttributedString attributedStringWithAttachment:textAttachment] ;
    [string insertAttributedString:textAttachmentString atIndex:_textV.selectedRange.location];//index为用户指定要插入图片的位置
    _textV.attributedText = string;
    
    self.topScrollerView.contentSize = CGSizeMake(kScreenWidth, CGRectGetMaxY(_textV.frame));
}

-(void)addTextAttributedLabel {
    
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

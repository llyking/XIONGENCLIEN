//
//  HKConstance.h
//  HKOnLine
//
//  Created by 徐小雷 on 16/8/23.
//  Copyright © 2016年 xuxiaolei. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - Common

UIKIT_EXTERN CGFloat const DelayTime;
UIKIT_EXTERN NSString * const TTClubkAlphaNum;
UIKIT_EXTERN NSString * const TTClubkInputNum;

UIKIT_EXTERN NSString * const DefaultZeroEndId;
UIKIT_EXTERN NSUInteger const DefaultRequestCount;
UIKIT_EXTERN NSUInteger const DefaultFirstPageNum;
UIKIT_EXTERN NSInteger const LSY_ALERTTITLE_WINDOW_TAG;

UIKIT_EXTERN NSString *const XFZChangeCityName;

static inline UIImage *HKFastImage(NSString *imageName) {
    return [UIImage imageNamed:imageName];
}

static inline NSString * TTStringNotNil(NSString *string) {
    return (string ? string : @"");
};
static inline NSString * TTStringNilToZero(NSString *string) {
    if ([string isEqualToString:@""]) {
        string = @"0";
        return string;
    }
    return string;
};

#pragma mark - 快捷适配函数


static inline CGFloat LSYCGRectGetMaxY(UIView *view) {
    return CGRectGetMaxY(view.frame);
}

static inline CGFloat LSYCGRectGetMaxX(UIView *view) {
    return CGRectGetMaxX(view.frame);
};

static inline UIFont *LSYUIFont(CGFloat fontSize) {
    return  [UIFont systemFontOfSize:fontSize];
};

/**
 *  适配5、6、6P~尺寸
 *  @param plist 参数列表，尺寸依次是多少例如(@[@10,@20,@30])
 *  @return 对应浮点数，例如g_fitFloat(@[@10,@20,@30])5返回10，6返回20，6P返回30; (@[@10,@20) 5返回10，6和6P返回20; (@[@10])5、6、6P都返回10。
 */
FOUNDATION_EXPORT CGFloat g_fitFloat(NSArray *plist);

/**
 *  适配4/4s、5、6、6P~尺寸
 *  @param plist 参数列表，尺寸依次是多少例如(@[@7,@10,@20,@30])
 *  @return 对应浮点数，例如(@[@7,@10,@20,@30])4/4s返回的是7 5返回10，6返回20，6P返回30; (@[@10,@20) 4s/5返回10，6和6P返回20; (@[@10])4、5、6、6P都返回10。
 */
FOUNDATION_EXPORT CGFloat g_fitFloatWith4s(NSArray * plist);
/**
 *  适配5、6、6P~尺寸
 *  @param plist 参数列表，字体大小依次是多少例如(@[@10,@20,@30])、(@[@10,@20)、(@[@10])
 *  @return 返回对应字体大小,(@[@10,@20,@30])5返回10号字体，6返回20号字体，6P返回30号字体; (@[@10,@20) 5返回10号字体，6和6P返回20号字体; (@[@10])5、6、6P都返回10号字体。
 */
FOUNDATION_EXPORT UIFont *g_fitSystemFontSize(NSArray *plist);

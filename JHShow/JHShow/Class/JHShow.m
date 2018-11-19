//
//  JHShow.m
//  JHShow
//
//  Created by 狄烨 . on 2018/11/19.
//  Copyright © 2018 狄烨 . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <Masonry/Masonry.h>

#import "JHShow.h"

#import "JHButton.h"
#import "JHLoadingView.h"
#import "JHShowConfig.h"
@implementation JHShow

+(UIWindow *)window{
    UIWindow *window =  [[[UIApplication sharedApplication] windows] lastObject];
    if(window && !window.hidden){
        return window;
    }
    window = [UIApplication sharedApplication].delegate.window;
    return window;
}

#pragma mark-Toast
/** 纯文本toast提示 */
+ (void)showText:(NSString *)text{
    [self showText:text withImage:nil];
}
/** 图文toast提示 */
+ (void)showText:(NSString *)text withImage:(UIImage *)image{
    // 背景view
    UIView *bgView = [[UIView alloc] init];
    [[self window] addSubview:bgView];
    bgView.backgroundColor = [JHShowConfig shared].toastBgColor;
    bgView.layer.cornerRadius = [JHShowConfig shared].toastCornerRadius;
    
    //////可以给toast添加点击事件,快速隐藏等等
    JHButton *btn = [[JHButton alloc] initWithType:[JHShowConfig shared].toastType AndMarginArr:@[[NSNumber numberWithFloat:[JHShowConfig shared].toastSpace]]];
    btn.backgroundColor = [UIColor clearColor];
    btn.image = image;
    btn.text = text;
    btn.contentLabel.textColor = [JHShowConfig shared].toastTextColor;
    btn.contentLabel.font = [JHShowConfig shared].toastTextFont;
    btn.contentLabel.numberOfLines = 0;
    btn.contentLabel.textAlignment =NSTextAlignmentCenter;
    [bgView addSubview:btn];

    // 设置背景view的约束
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(bgView.superview);
    }];
    
    // 设置label的约束
    [btn.contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_lessThanOrEqualTo(200);
    }];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(btn.superview).offset(10);
        make.bottom.right.equalTo(btn.superview).offset(-10);
    }];
    // 2秒后移除toast
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)([JHShowConfig shared].toastShowTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.5 animations:^{
            bgView.alpha = 0;
        } completion:^(BOOL finished) {
            [bgView removeFromSuperview];
        }];
    });
}

#pragma mark - loading
/**
 loading期间，允许或禁止用户交互
 @param isEnable YES:允许 NO:禁止
 */
+ (void)loadingEnableEvent:(BOOL)isEnable{
    [JHLoadingView shareLoading].userInteractionEnabled = !isEnable;
}
/** 移除loading图 */
+ (void)hidenLoading{
    [[JHLoadingView shareLoading] removeFromSuperview];
}

/**
 带说明信息loading图
 @param text 说明信息
 默认无交互
 */
+ (void)showLoadingText:(NSString *)text{
    [[self window] addSubview:[JHLoadingView shareLoading]];
    [JHLoadingView shareLoading].text = text;
    [[JHLoadingView shareLoading] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

/** 展示loading图 默认无交互 */
+ (void)showLoading{
    [JHShow showLoadingText:nil];
}

/**
 展示可控制用户交互并且带说明信息的loading图
 @param text 说明信息
 @param isEnable 是否允许用户交互
 */
+ (void)showLoadingText:(NSString *)text enableEvent:(BOOL)isEnable{
    [JHShow showLoadingText:text];
    [JHShow loadingEnableEvent:isEnable];
}
/**
  展示可交互的loading图
  */
+ (void)showLoadingEvent{
    [JHShow showLoadingText:nil enableEvent:YES];
}
/**
 展示可交互并且带说明信息的loading图
 @param text 说明信息
 */
+ (void)showLoadingEventText:(NSString *)text{
    [JHShow showLoadingText:text enableEvent:YES];
}

@end

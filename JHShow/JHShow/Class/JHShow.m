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
#import <JHButton/JHButton.h>
#import "JHShow.h"
#import "JHToastView.h"
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
    
    //显示之前隐藏还在显示的视图
    NSEnumerator *subviewsEnum = [[self window].subviews reverseObjectEnumerator];
    for (UIView *subview in subviewsEnum) {
        if ([subview isKindOfClass:[JHToastView class]]) {
            JHToastView *showView = (JHToastView *)subview ;
            [showView removeFromSuperview];
        }
    }
    // 背景view
    JHToastView *toastView = [[JHToastView alloc] init];
    toastView.text = text;
    toastView.image = image;
    [[self window] addSubview:toastView];
    [toastView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(toastView.superview);
    }];
    
    // 2秒后移除toast
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)([JHShowConfig shared].toastShowTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.5 animations:^{
            toastView.alpha = 0;
        } completion:^(BOOL finished) {
            [toastView removeFromSuperview];
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


#pragma mark - popview

+(JHPopView *)showPopViewCenter:(UIView *)contentView
                animsted:(BOOL)animsted{
    JHPopView *popView = [JHPopView popContentView:contentView animated:animsted];
    return popView;
}

+(JHPopView *)showPopView:(UIView *)contentView
                showType:(PopViewShowType)showType{
    JHPopView *popView = [JHPopView popContentView:contentView withShowType:showType];
    return popView;
}

+ (void)hidenPopView{
    [JHPopView hidenPopView];
}

@end

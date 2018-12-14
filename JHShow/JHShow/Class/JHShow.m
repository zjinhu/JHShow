//
//  JHShow.m
//  JHShow
//
//  Created by 狄烨 . on 2018/11/19.
//  Copyright © 2018 狄烨 . All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
#import "JHShow.h"
#import "JHToastView.h"

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
 展示可控制用户交互并且带说明信息的loading图
 @param text 说明信息
 @param view 展示位置
 @param isEnable 是否允许用户交互
 */
+ (JHLoadingView *)showLoadingText:(NSString *)text onView:(UIView*)view enableEvent:(BOOL)isEnable{
    JHLoadingView *loadingView = [JHLoadingView new];
    if (view) {
        [self hidenLoadingOnView:view];
        [view addSubview:loadingView];
    }else{
        [self hidenLoading];
        [[self window] addSubview:loadingView];
    }
    loadingView.text = text;
    loadingView.userInteractionEnabled = isEnable;
    [loadingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    return loadingView;
}

+ (JHLoadingView *)showLoadingText:(NSString *)text{
    return [self showLoadingText:text onView:nil enableEvent:YES];
}

+ (JHLoadingView *)showLoading{
    return [self showLoadingText:nil onView:nil enableEvent:YES];
}
/**
 loading图展示在UIview上
 */
+ (JHLoadingView *)showLoadingText:(NSString *)text onView:(UIView*)view{
    return [self showLoadingText:text onView:view enableEvent:NO];
}

+ (JHLoadingView *)showLoadingOnView:(UIView *)view{
    return [self showLoadingText:nil onView:view];
}
/** 移除loading图 */
+ (void)hidenLoading{
    [self hidenLoadingOnView:[self window]];
}

+ (void)hidenLoading:(JHLoadingView *)loadingView{
    [loadingView removeFromSuperview];
}

+ (void)hidenLoadingOnView:(UIView *)view{
    NSEnumerator *subviewsEnum = [view.subviews reverseObjectEnumerator];
    for (UIView *subview in subviewsEnum) {
        if ([subview isKindOfClass:[JHLoadingView class]]) {
            JHLoadingView *loadingView = (JHLoadingView *)subview ;
            [self hidenLoading:loadingView];
        }
    }
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

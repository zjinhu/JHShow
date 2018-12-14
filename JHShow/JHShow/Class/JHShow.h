//
//  JHShow.h
//  JHShow
//
//  Created by 狄烨 . on 2018/11/19.
//  Copyright © 2018 狄烨 . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JHPopView.h"
#import "JHLoadingView.h"
@interface JHShow : NSObject
#pragma mark-Toast
/** 纯文本toast提示 */
+ (void)showText:(NSString *)text;
/** 图文toast提示 */
+ (void)showText:(NSString *)text withImage:(UIImage *)image;

#pragma mark - loading
/** 展示loading图    默认允许用户交互*/
+ (JHLoadingView *)showLoading;
/**带说明信息loading图  默认允许用户交互*/
+ (JHLoadingView *)showLoadingText:(NSString *)text;

/** 在UIView上展示loading图    默认不允许用户交互*/
+ (JHLoadingView *)showLoadingOnView:(UIView *)view;
/** 在UIView上展示loading图    默认不允许用户交互*/
+ (JHLoadingView *)showLoadingText:(NSString *)text onView:(UIView*)view;

/** 移除loading图 */
+ (void)hidenLoading;

/** 移除UIview上loading图 */
+ (void)hidenLoading:(JHLoadingView *)loadingView;
+ (void)hidenLoadingOnView:(UIView *)view;
#pragma mark - popview
/**
 从屏幕中间弹出视图，可控制缩放动画
 @param contentView 需要弹出的视图
 @param animsted 是否需要缩放动画
 */
+ (JHPopView *)showPopViewCenter:(UIView *)contentView
                animsted:(BOOL)animsted;
/**
 从屏幕外弹出视图，可控制方向
 @param contentView 需要弹出的视图
 @param showType 动画方向
 */
+ (JHPopView *)showPopView:(UIView *)contentView
                showType:(PopViewShowType)showType;
/**
移除popView
 */
+ (void)hidenPopView;
@end


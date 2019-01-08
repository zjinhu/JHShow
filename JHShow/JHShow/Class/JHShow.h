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
#import "JHAlertView.h"
@interface JHShow : NSObject
#pragma mark-Toast
/** 纯文本toast提示 */
+ (void)showText:(NSString *)text;
/** 图文toast提示 */
+ (void)showText:(NSString *)text withImage:(UIImage *)image;

#pragma mark - loading
/** 在TopVC展示loading图    默认允许用户交互*/
+ (JHLoadingView *)showLoading;
/**在TopVC带说明信息loading图  默认允许用户交互*/
+ (JHLoadingView *)showLoadingText:(NSString *)text;

/** 在UIView上展示loading图    默认不允许用户交互*/
+ (JHLoadingView *)showLoadingOnView:(UIView *)view;
/** 在UIView上展示loading图    默认不允许用户交互*/
+ (JHLoadingView *)showLoadingText:(NSString *)text onView:(UIView*)view;

/** 在UIWindow上展示loading图    默认允许用户交互*/
+ (JHLoadingView *)showLoadingOnWindow;
/** 在UIWindow上展示loading图    默认允许用户交互*/
+ (JHLoadingView *)showLoadingTextOnWindow:(NSString *)text;

/** 移除TopVC上loading图 */
+ (void)hidenLoading;
/** 移除Window上loading图 */
+ (void)hidenLoadingOnWindow;
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

#pragma mark - alert
/**
 @param title alert标题
 @param image 标题图片
 @param message 信息
 @param leftTitle 左侧按钮文案/不传就是只有一个按钮
 @param rigthTitle 右侧按钮文案
 @param leftBlock 左侧按钮回调
 @param rightBlock 右侧按钮回调
 */
+ (JHAlertView *)showAlertWithTitle:(NSString *)title
                               image:(UIImage *)image
                         messageText:(id)message
                     leftButtonTitle:(NSString *)leftTitle
                    rightButtonTitle:(NSString *)rigthTitle
                           leftBlock:(dispatch_block_t)leftBlock
                          rightBlock:(dispatch_block_t)rightBlock;
/**
 移除Alert
 */
+(void)dismissAlert;
@end


//
//  JHShow.h
//  JHShow
//
//  Created by 狄烨 . on 2018/11/19.
//  Copyright © 2018 狄烨 . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JHPopView.h"

@interface JHShow : NSObject
#pragma mark-Toast
/** 纯文本toast提示 */
+ (void)showText:(NSString *)text;
/** 图文toast提示 */
+ (void)showText:(NSString *)text withImage:(UIImage *)image;

#pragma mark - loading

/** 移除loading图 */
+ (void)hidenLoading;

/** 展示loading图    默认不允许用户交互*/
+ (void)showLoading;
/**
 带说明信息loading图
 @param text 说明信息
 默认不允许用户交互
 */
+ (void)showLoadingText:(NSString *)text;

/**
 展示可交互的loading图
 */
+ (void)showLoadingEvent;
/**
 展示可交互并且带说明信息的loading图
 @param text 说明信息
 */
+ (void)showLoadingEventText:(NSString *)text;

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


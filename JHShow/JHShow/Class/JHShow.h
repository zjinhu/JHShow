//
//  JHShow.h
//  JHShow
//
//  Created by 狄烨 . on 2018/11/19.
//  Copyright © 2018 狄烨 . All rights reserved.
//

#import <Foundation/Foundation.h>

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
@end


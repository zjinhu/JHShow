//
//  JHShowConfig.h
//  JHShow
//
//  Created by 狄烨 . on 2018/11/19.
//  Copyright © 2018 狄烨 . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <JHButton/JHButton.h>


#define iS_iPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define iPhone_X     (iS_iPhone && [[UIScreen mainScreen] bounds].size.height >= 812)  //iPhoneX刘海系列
#define HOME_HEIGHT (iPhone_X ? 34.f : 0.f)
#define NAV_BAR_HEIGHT (iPhone_X ? 88.f : 64.f)

#define ColorFromName(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

NS_ASSUME_NONNULL_BEGIN

@interface JHShowConfig : NSObject

+ (instancetype)shared;

#pragma mark - ///////////loading/////////////
/** loading最大宽度 默认130 **/
@property (nonatomic,assign) CGFloat loadingMaxWidth;
/** 圆角大小 默认5 **/
@property (nonatomic,assign) CGFloat loadingCornerRadius;
/** 加载框主体颜色 默认白色 **/
@property (nonatomic,strong) UIColor *loadingTintColor;
/** 文字字体大小 默认系统字体15 **/
@property (nonatomic,strong) UIFont  *loadingTextFont;
/** 文字字体颜色 默认黑色 **/
@property (nonatomic,strong) UIColor *loadingTextColor;
/** 背景颜色 默认蒙版  **/
@property (nonatomic,strong) UIColor *loadingBgColor;
/** 阴影颜色 默认clearcolor **/
@property (nonatomic,strong) UIColor *loadingShadowColor;
/** 阴影Opacity 默认0.5 **/
@property (nonatomic,assign) CGFloat loadingShadowOpacity;
/** 阴影Radius 默认5 **/
@property (nonatomic,assign) CGFloat loadingShadowRadius;
/** 图片动画类型 所需要的图片数组 **/
@property (nonatomic,strong) NSArray <UIImage *> *loadingImagesArray;
/** 菊花颜色 不传递图片数组的时候默认使用菊花**/
@property (nonatomic,strong) UIColor *activityColor;
/** 动画时间 默认0.5 **/
@property (nonatomic,assign) CGFloat loadingAnimationTime;
/** loading图文混排样式  默认图片在上**/
@property (nonatomic,assign) JHImageButtonType loadingType;
/** loading背景与内容之间的上下边距 默认10 **/
@property (nonatomic,assign) CGFloat loadingVerticalPadding;
/** loading背景与内容之间的左右边距 默认10 **/
@property (nonatomic,assign) CGFloat loadingHorizontalPadding;
/** loading文字与图片之间的距 默认0 **/
@property (nonatomic,assign) CGFloat loadingSpace;
#pragma mark - ////////////toast////////////////
/** Toast最大宽度  默认200 **/
@property (nonatomic,assign) CGFloat toastMaxWidth;
/** Toast默认停留时间 默认2秒 **/
@property (nonatomic,assign) CGFloat toastShowTime;
/** Toast圆角 默认5 **/
@property (nonatomic,assign) CGFloat toastCornerRadius;
/** Toast图文间距  默认5 **/
@property (nonatomic,assign) CGFloat toastSpace;
/** Toast字体  默认15 **/
@property (nonatomic,strong) UIFont *toastTextFont;
/** Toast背景颜色 默认黑色 **/
@property (nonatomic,strong) UIColor *toastBgColor;
/** 阴影颜色 默认clearcolor **/
@property (nonatomic,strong) UIColor *toastShadowColor;
/** 阴影Opacity 默认0.5 **/
@property (nonatomic,assign) CGFloat toastShadowOpacity;
/** 阴影Radius 默认5 **/
@property (nonatomic,assign) CGFloat toastShadowRadius;
/**  Toast文字字体颜色 默认白色 **/
@property (nonatomic,strong) UIColor *toastTextColor;
/** Toast图文混排样式 默认图片在上**/
@property (nonatomic,assign) JHImageButtonType toastType;
/** Toast背景与内容之间的内边距 默认10**/
@property (nonatomic,assign) CGFloat toastPadding;
#pragma mark - ////////////alert////////////////
/** alert最大宽度 **/
@property (nonatomic,assign) CGFloat alertMaxWidth;
/** alert最大高度 **/
@property (nonatomic,assign) CGFloat alertMaxHeight;
/** alert圆角 **/
@property (nonatomic,assign) CGFloat alertCornerRadius;
/** alert图文混排样式 **/
@property (nonatomic,assign) JHImageButtonType alertType;
/** alert图文间距 **/
@property (nonatomic,assign) CGFloat alertSpace;
/** alert标题字体 **/
@property (nonatomic,strong) UIFont *alertTitleFont;
/**  alert标题字体颜色 **/
@property (nonatomic,strong) UIColor *alertTitleColor;
/** alert信息字体 **/
@property (nonatomic,strong) UIFont *alertTextFont;
/**  alert信息字体颜色 **/
@property (nonatomic,strong) UIColor *alertTextColor;
/** alert按钮字体 **/
@property (nonatomic,strong) UIFont *alertButtonFont;
/**  alert按钮字体颜色 **/
@property (nonatomic,strong) UIColor *alertLeftColor;
@property (nonatomic,strong) UIColor *alertRightColor;
/** alert背景颜色 **/
@property (nonatomic,strong) UIColor *alertBgColor;
/** 阴影 **/
@property (nonatomic,strong) UIColor *alertShadowColor;
@property (nonatomic,assign) CGFloat alertShadowOpacity;
@property (nonatomic,assign) CGFloat alertShadowRadius;
@end

NS_ASSUME_NONNULL_END

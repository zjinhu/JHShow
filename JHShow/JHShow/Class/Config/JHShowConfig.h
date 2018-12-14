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

// .h
#define SingletonH  + (instancetype)shared ;
// .m
#define SingletonM(class) \
static class *_showInstance; \
+ (id)allocWithZone:(struct _NSZone *)zone { \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_showInstance = [super allocWithZone:zone]; \
}); \
return _showInstance; \
} \
+ (instancetype)shared { \
if (nil == _showInstance) { \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_showInstance = [[class alloc] init]; \
}); \
} \
return _showInstance; \
} \
- (id)copyWithZone:(NSZone *)zone{ \
return _showInstance; \
} \
- (id)mutableCopyWithZone:(NSZone *)zone{ \
return _showInstance; \
} \

#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define iPhoneX     (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height >= 812)  //iPhoneX刘海系列
#define HOME_INDICATOR_HEIGHT (iPhoneX ? 34.f : 0.f)

NS_ASSUME_NONNULL_BEGIN

@interface JHShowConfig : NSObject

SingletonH

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

@end

NS_ASSUME_NONNULL_END
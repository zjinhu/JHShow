//
//  JHPopView.h
//  JHShow
//
//  Created by 狄烨 . on 2018/11/20.
//  Copyright © 2018 狄烨 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,PopViewShowType) {
    /** contentView位居PopView的顶部 默认动画也是从顶部开始*/
    PopViewShowTypeTop = 1,
    /***  contentView位居PopView的底部 默认动画也是从底部开始*/
    PopViewShowTypeBottom,
    /***  contentView位居PopView的右边 默认动画也是从右边开始*/
    PopViewShowTypeRight,
    /***  contentView位居PopView的左边 默认动画也是从左边开始*/
    PopViewShowTypeLeft
};
NS_ASSUME_NONNULL_BEGIN

@interface JHPopView : UIView

@property (nonatomic ,assign) BOOL clickOutHidden;      //点击其他地方是否消失 默认yes

//popView的移除回调
@property (nonatomic ,copy) void(^hiddenPop)(void);

/*
 在window上从屏幕中间显示出控件
 @param contentView 要显示的控件内容
 **/
+ (instancetype)popContentView:(UIView *)contentView animated:(BOOL)animated;
/*
 在window上从屏幕外边显示出控件
 @param contentView 要显示的控件内容
  @param type 样式
 **/
+ (instancetype)popContentView:(UIView *)contentView withShowType:(PopViewShowType)type;

//隐藏当前的popView
+ (void)hidenPopView;

//获取当前的popView
+ (instancetype)getCurrentPopView;
@end

NS_ASSUME_NONNULL_END

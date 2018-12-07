//
//  JHPresentation.h
//  JHShow
//
//  Created by 狄烨 . on 2018/12/7.
//  Copyright © 2018 狄烨 . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,PresentationType) {
    /**contentView位居PopView的中间 默认无动画*/
    PresentationTypeDefult,
    /**contentView位居PopView的顶部 默认动画从顶部开始顶部消失*/
    PresentationTypeTop = 1,
    /**contentView位居PopView的底部 默认动画从底部开始底部消失*/
    PresentationTypeBottom,
    /**contentView位居PopView的右边 默认动画从右边开始右边消失*/
    PresentationTypeRight,
    /**contentView位居PopView的左边 默认动画从左边开始左边消失*/
    PresentationTypeLeft
};
@interface JHPresentation : UIPresentationController<UIViewControllerTransitioningDelegate>

/// 是否允许点击灰色蒙板处来dismiss，默认YES
@property(nonatomic, assign) BOOL allowTapDismiss;

/// 键盘显示与隐藏监听，default：YES
@property(nonatomic, assign) BOOL allowObserverForKeyBoard;

/// 转场动画时间，默认0.35s
@property(nonatomic, assign) NSTimeInterval transitionDuration;
//popView的移除回调
@property (nonatomic ,copy) void(^hiddenPresentation)(void);
/**
 * 转场形式显示popView
 * 自适应位置
 * ⚠️调用该方法时，请先设定好popView的frame
 *
 * @param popView 要显示的View
 * @return 返回转场代理对象
 */
+ (instancetype)showView:(UIView *)popView;

+ (instancetype)showView:(UIView *)contentView withShowType:(PresentationType)type;

- (void)dismiss;

@end

NS_ASSUME_NONNULL_END

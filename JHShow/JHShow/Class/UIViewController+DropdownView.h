//
//  UIViewController+PopView.h
//  JHShow
//
//  Created by 狄烨 . on 2019/1/2.
//  Copyright © 2019 HU. All rights reserved.
//

#import <UIKit/UIKit.h>
/**顶部菜单弹出样式,仅限于顶部可用于导航栏弹出,或者导航栏下边紧邻视图弹出*/
@interface UIViewController (DropdownView)
/**是否处在展示的状态*/
@property (nonatomic, assign) BOOL dropdownShown;
/**从导航栏下方弹出视图*/
- (void)showDropdownController:(UIViewController *)dropdownController dropdownHeight:(CGFloat)height;
/**从fromView下方弹出视图*/
- (void)showDropdownController:(UIViewController *)dropdownController fromView:(UIView *)fromView dropdownHeight:(CGFloat)height;
/**收回弹出视图*/
- (void)hideDropdownController;
@end


//
//  UIViewController+DropdownView.m
//  JHShow
//
//  Created by 狄烨 . on 2019/1/2.
//  Copyright © 2019 HU. All rights reserved.
//

#import "UIViewController+DropdownView.h"
#import <objc/runtime.h>
#import "JHShowConfig.h"
@interface UIViewController ()
/**弹出视图的蒙版*/
@property (nonatomic, strong) UIControl *dimView;
/**弹出视图的控制器*/
@property (nonatomic, strong) UIViewController *dropdownController;
/**弹出视图的高度,展示不开的请在控制器内使用table或者scroolview*/
@property (nonatomic, assign) CGFloat dropdownHeight;
@end

@implementation UIViewController (DropdownView)
- (void)setDimView:(UIView *)dimView{
    objc_setAssociatedObject(self, @selector(dimView), dimView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)dimView{
    return objc_getAssociatedObject(self, @selector(dimView));
}

- (void)setDropdownController:(UIViewController *)dropdownController{
    objc_setAssociatedObject(self, @selector(dropdownController), dropdownController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIViewController *)dropdownController{
    return objc_getAssociatedObject(self, @selector(dropdownController));
}

- (CGFloat)dropdownHeight {
    return [objc_getAssociatedObject(self, @selector(dropdownHeight)) floatValue];
}

- (void)setDropdownHeight:(CGFloat)dropdownHeight {
    objc_setAssociatedObject(self, @selector(dropdownHeight), @(dropdownHeight), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)dropdownShown{
    return [objc_getAssociatedObject(self, @selector(dropdownShown)) boolValue];
}

- (void)setDropdownShown:(BOOL)dropdownShown {
    objc_setAssociatedObject(self, @selector(dropdownShown), @(dropdownShown), OBJC_ASSOCIATION_ASSIGN);
}

- (void)showDropdownController:(UIViewController *)dropdownController dropdownHeight:(CGFloat)height{
    [self showDropdownController:dropdownController fromView:nil dropdownHeight:height];
}

- (void)showDropdownController:(UIViewController *)dropdownController fromView:(UIView *)fromView dropdownHeight:(CGFloat)height{
    
    if (self.dimView) {
        [self.dimView removeFromSuperview];
        self.dimView = nil;
        [self.dropdownController.view removeFromSuperview];
        [self.dropdownController removeFromParentViewController];
        self.dropdownHeight = 0;
    }
    
    self.dropdownController = dropdownController;
    self.dropdownHeight = height;

    self.dimView = [[UIControl alloc] initWithFrame:self.view.bounds];
    self.dimView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    [self.dimView addTarget:self action:@selector(hideDropdownController) forControlEvents:UIControlEventTouchUpInside];

    [UIView transitionWithView:self.view
                      duration:0.2f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        [self.view addSubview:self.dimView];
                        if (fromView) {
                            [self.view insertSubview:self.dimView belowSubview:fromView];
                        }
                    } completion:^(BOOL finished) {
                        [self addChildViewController:self.dropdownController];
                        self.dropdownController.view.frame = CGRectMake(0, -self.dropdownHeight, CGRectGetWidth(self.view.bounds), self.dropdownHeight);
                        [self.view addSubview:self.dropdownController.view];
                        if (fromView) {
                            [self.view insertSubview:self.dropdownController.view belowSubview:fromView];
                        }
                        [UIView animateWithDuration:0.2f
                                         animations:^{
                                             self.dropdownController.view.frame = CGRectMake(0, fromView ? CGRectGetMaxY(fromView.frame) : NAV_BAR_HEIGHT, CGRectGetWidth(self.view.bounds),self.dropdownHeight);
                                         } completion:^(BOOL finished) {
                                             self.dropdownShown = YES;
                                         }];
                    }];
}

- (void)hideDropdownController{
    [UIView transitionWithView:self.view
                      duration:0.2f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        [self.dimView removeFromSuperview];
                        self.dimView = nil;
                    } completion:^(BOOL finished) {
                        [UIView animateWithDuration:0.2f
                                         animations:^{
                                             self.dropdownController.view.frame = CGRectMake(0, -self.dropdownHeight, CGRectGetWidth(self.view.bounds), self.dropdownHeight);
                                         } completion:^(BOOL finished) {
                                             [self.dropdownController.view removeFromSuperview];
                                             [self.dropdownController removeFromParentViewController];
                                             self.dropdownHeight = 0;
                                             self.dropdownShown = NO;
                                         }];
                    }];
}

@end

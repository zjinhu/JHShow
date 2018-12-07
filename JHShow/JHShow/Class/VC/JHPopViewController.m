//
//  JHPopViewController.m
//  JHShow
//
//  Created by 狄烨 . on 2018/12/7.
//  Copyright © 2018 狄烨 . All rights reserved.
//

#import "JHPopViewController.h"

@interface JHPopViewController ()

@end

@implementation JHPopViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self updatePreferredContentSizeWithTraitCollection:self.traitCollection];
}

// 当视图控制器的特征集合被其父控件更改时，将调用此方法。
- (void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    [super willTransitionToTraitCollection:newCollection withTransitionCoordinator:coordinator];
    
    [self updatePreferredContentSizeWithTraitCollection:newCollection];
}

- (void)updatePreferredContentSizeWithTraitCollection:(UITraitCollection *)traitCollection{
    // 指定视图大小
    self.preferredContentSize = self.popView.bounds.size;
}


- (void)setPopView:(UIView *)popView {
    _popView = popView;
    [self.view addSubview:popView];
    self.view.backgroundColor = [UIColor clearColor];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    CGRect frame = _popView.frame;
    frame.origin = CGPointZero;
    _popView.frame = frame;
}

- (void)updateContentSize {
    [self updatePreferredContentSizeWithTraitCollection:self.traitCollection];
}

@end

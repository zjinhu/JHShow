//
//  JHPopView.m
//  JHShow
//
//  Created by 狄烨 . on 2018/11/20.
//  Copyright © 2018 狄烨 . All rights reserved.
//

#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define iPhoneX     (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height >= 812)  //iPhoneX刘海系列
#define HOME_INDICATOR_HEIGHT (iPhoneX ? 34.f : 0.f)
#import "JHPopView.h"
static const CGFloat animationTime = 0.25;
@interface JHPopView()<UIGestureRecognizerDelegate>
@property (nonatomic ,weak) UIView *contentView;
@property (nonatomic ,assign) BOOL animation;
@property (nonatomic ,strong) UIResponder *backCtl;
@property (nonatomic,assign) PopViewShowType showType;
@property (nonatomic,assign) CGRect showFrame;
@property (nonatomic,assign) CGRect hideFrame;
@property (nonatomic ,strong) UIView *popContainerView; //包含要显示的View的父控件
@property (nonatomic,assign) CGRect contentFrame;
@end
@implementation JHPopView

- (instancetype)initWithFrame:(CGRect)frame
                  contentView:(UIView *)contentView
                     showType:(PopViewShowType)showType
                    animation:(BOOL)animation{
    self = [super initWithFrame:frame];
    if (self) {
        self.animation = animation;
        self.contentView = contentView;
        _contentFrame =contentView.frame;
        self.clickOutHidden = YES;
        if (showType!=0) {
            self.showType = showType;
        }
        UIControl *backCtl = [[UIControl alloc] initWithFrame:self.bounds];
        [self addSubview:backCtl];
        self.backCtl = backCtl;
        [backCtl addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];

        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
    }
    return self;
}

- (void)setShowType:(PopViewShowType)showType{
    _showType = showType;
    /**
     *  计算出_contentView的动画的 起始位置 和 中止位置
     */
    if (_showType == PopViewShowTypeTop) {
        _showFrame = CGRectMake(_contentFrame.origin.x, _contentFrame.origin.y, CGRectGetWidth(_contentFrame), CGRectGetHeight(_contentFrame));
        _hideFrame = CGRectMake(_contentFrame.origin.x, -CGRectGetHeight(_contentFrame)-_contentFrame.origin.y, CGRectGetWidth(_contentFrame), CGRectGetHeight(_contentFrame));
    }
    if (_showType == PopViewShowTypeBottom) {
        _showFrame = CGRectMake(_contentFrame.origin.x, CGRectGetHeight(self.frame)-HOME_INDICATOR_HEIGHT- CGRectGetHeight(_contentFrame)-_contentFrame.origin.y, CGRectGetWidth(_contentFrame), CGRectGetHeight(_contentFrame));
        _hideFrame = CGRectMake(_contentFrame.origin.x, CGRectGetMaxY(self.frame)+_contentFrame.origin.y,CGRectGetWidth(_contentFrame), CGRectGetHeight(_contentFrame));
    }
    if (_showType == PopViewShowTypeLeft) {
        _showFrame = CGRectMake(_contentFrame.origin.x, _contentFrame.origin.y, CGRectGetWidth(_contentFrame), CGRectGetHeight(_contentFrame));
        _hideFrame = CGRectMake(-CGRectGetWidth(_contentFrame), _contentFrame.origin.y, CGRectGetWidth(_contentFrame), CGRectGetHeight(_contentFrame));
    }
    if (_showType == PopViewShowTypeRight) {
        _showFrame = CGRectMake(_contentFrame.origin.x, _contentFrame.origin.y, CGRectGetWidth(_contentFrame), CGRectGetHeight(_contentFrame));
        _hideFrame = CGRectMake(CGRectGetWidth(_contentFrame), _contentFrame.origin.y, CGRectGetWidth(_contentFrame), CGRectGetHeight(_contentFrame));
    }
    self.popContainerView.frame = _hideFrame;
}

- (void)backClick{
    if (self.clickOutHidden) {
        [JHPopView hidenPopView];
    }
}

- (void)remove{
    if (self.hiddenPop) {
        self.hiddenPop();
    }
    [super removeFromSuperview];
}

- (UIView *)popContainerView{
    if (!_popContainerView) {
        _popContainerView = [[UIView alloc] init];
    }
    return _popContainerView;
}

-(void)dealloc{
    NSLog(@"释放了");
}

#pragma mark - 类方法

+(UIWindow *)window{
    UIWindow *window =  [[[UIApplication sharedApplication] windows] lastObject];
    if(window && !window.hidden){
        return window;
    }
    window = [UIApplication sharedApplication].delegate.window;
    return window;
}

+ (instancetype)getCurrentPopView{
    NSEnumerator *subviewsEnum = [[self window].subviews reverseObjectEnumerator];
    for (UIView *subview in subviewsEnum) {
        if ([subview isKindOfClass:[JHPopView class]]) {
            JHPopView *showView = (JHPopView *)subview ;
            return showView;
        }
    }
    return nil;
}

+ (instancetype)popContentView:(UIView *)contentView animated:(BOOL)animated{
    JHPopView *oldPopView = [self getCurrentPopView];
    [oldPopView removeFromSuperview];
    
    JHPopView *newPopView = [[JHPopView alloc] initWithFrame:[self window].bounds
                                             contentView:contentView
                                                    showType:0
                                               animation:animated];
    [[self window] addSubview:newPopView];
    [newPopView addSubview:contentView];
    contentView.center = newPopView.center;
    
    newPopView.clipsToBounds = YES;
    if (animated) {
        contentView.transform = CGAffineTransformScale(CGAffineTransformIdentity,
                                                CGFLOAT_MIN, CGFLOAT_MIN);
        [UIView animateWithDuration:animationTime animations:^{
            contentView.transform = CGAffineTransformIdentity;
        }];
    }
    return newPopView;
}

+ (instancetype)popContentView:(UIView *)contentView withShowType:(PopViewShowType)type{
    JHPopView *oldPopView = [self getCurrentPopView];
    [oldPopView removeFromSuperview];
    
    JHPopView *newPopView = [[JHPopView alloc] initWithFrame:[self window].bounds
                                                 contentView:contentView
                                                    showType:type
                                                   animation:YES];
    [[self window] addSubview:newPopView];
    [newPopView.popContainerView addSubview:contentView];
    [newPopView addSubview:newPopView.popContainerView];
    
    [UIView animateWithDuration:animationTime animations:^{
        newPopView.popContainerView.frame = newPopView.showFrame;
    }];
    return newPopView;
}

+ (void)hidenPopView{
    JHPopView *popView = [self getCurrentPopView];
    if (popView.showType != 0) {
        [UIView animateWithDuration:animationTime
                         animations:^{
                             popView.popContainerView.frame = popView.hideFrame;
                         }
                         completion:^(BOOL finished) {
                             [popView remove];
                         }];
    }else{
        if (popView.animation) {
            [UIView animateWithDuration:animationTime
                             animations:^{
                                 popView.contentView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
                             }
                             completion:^(BOOL finished) {
                                 [popView remove];
                             }];
        } else {
            [popView remove];
        }
    }

}


@end
